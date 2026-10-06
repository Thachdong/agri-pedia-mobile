import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/core/network/cursor_page.dart';
import 'package:ui_ux/core/pagination/paginated_notifier.dart';

import '../../helpers/pump_app.dart';

typedef _Fetch = Future<CursorPage<int>> Function(String? cursor);

class _Pages extends AsyncNotifier<PaginatedState<int>>
    with PaginatedNotifier<int> {
  _Pages(this._fetch);

  final _Fetch _fetch;

  @override
  Future<PaginatedState<int>> build() => loadFirstPage();

  @override
  Future<CursorPage<int>> fetchPage(String? cursor) => _fetch(cursor);
}

const _error = ApiException(code: 'TIMEOUT', message: 'slow');

void main() {
  late List<String?> cursors;
  late AsyncNotifierProvider<_Pages, PaginatedState<int>> provider;

  /// Pages keyed by cursor (null = first page).
  ProviderContainer setUp(Map<String?, Object> pages) {
    cursors = [];
    provider = AsyncNotifierProvider<_Pages, PaginatedState<int>>(
      () => _Pages((cursor) async {
        cursors.add(cursor);
        final page = pages[cursor];
        if (page is Completer<CursorPage<int>>) return page.future;
        if (page is CursorPage<int>) return page;
        throw page!;
      }),
    );
    return makeContainer();
  }

  test('build loads the first page', () async {
    final c = setUp({
      null: const CursorPage(items: [1, 2], nextCursor: 'c2'),
    });

    final state = await c.read(provider.future);

    expect(state.items, [1, 2]);
    expect(state.nextCursor, 'c2');
    expect(cursors, [null]);
  });

  test('first page error → AsyncError', () async {
    final c = setUp({null: _error});
    c.listen(provider, (_, _) {});

    await expectLater(c.read(provider.future), throwsA(_error));
    expect(c.read(provider).error, _error);
  });

  test('loadMore appends with the cursor, stops on last page', () async {
    final c = setUp({
      null: const CursorPage(items: [1, 2], nextCursor: 'c2'),
      'c2': const CursorPage(items: [3]),
    });
    await c.read(provider.future);
    final notifier = c.read(provider.notifier);

    await notifier.loadMore();
    await notifier.loadMore(); // last page: no request

    final state = c.read(provider).requireValue;
    expect(state.items, [1, 2, 3]);
    expect(state.hasMore, isFalse);
    expect(cursors, [null, 'c2']);
  });

  test('concurrent loadMore fetches once', () async {
    final next = Completer<CursorPage<int>>();
    final c = setUp({
      null: const CursorPage(items: [1], nextCursor: 'c2'),
      'c2': next,
    });
    await c.read(provider.future);
    final notifier = c.read(provider.notifier);

    final first = notifier.loadMore();
    expect(c.read(provider).requireValue.isLoadingMore, isTrue);
    unawaited(notifier.loadMore());
    next.complete(const CursorPage(items: [2]));
    await first;

    expect(cursors, [null, 'c2']);
    expect(c.read(provider).requireValue.items, [1, 2]);
  });

  test('load-more error keeps items; retry clears the error', () async {
    final pages = <String?, Object>{
      null: const CursorPage(items: [1], nextCursor: 'c2'),
      'c2': _error,
    };
    final c = setUp(pages);
    await c.read(provider.future);
    final notifier = c.read(provider.notifier);

    await notifier.loadMore();
    var state = c.read(provider).requireValue;
    expect(state.items, [1]);
    expect(state.loadMoreError, _error);
    expect(state.isLoadingMore, isFalse);
    expect(state.nextCursor, 'c2');

    pages['c2'] = const CursorPage(items: [2]);
    await notifier.loadMore();
    state = c.read(provider).requireValue;
    expect(state.items, [1, 2]);
    expect(state.loadMoreError, isNull);
  });

  test('updateItems edits loaded items locally', () async {
    final c = setUp({
      null: const CursorPage(items: [1, 2], nextCursor: 'c2'),
    });
    await c.read(provider.future);

    c.read(provider.notifier).updateItems((items) => [0, ...items]);

    final state = c.read(provider).requireValue;
    expect(state.items, [0, 1, 2]);
    expect(state.nextCursor, 'c2');
  });

  test('refresh reloads from the first page', () async {
    final c = setUp({
      null: const CursorPage(items: [1], nextCursor: 'c2'),
    });
    c.listen(provider, (_, _) {});
    await c.read(provider.future);

    c.read(provider.notifier).refresh();
    await c.read(provider.future);

    expect(cursors, [null, null]);
  });
}
