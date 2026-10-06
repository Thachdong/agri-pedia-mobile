import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/core/pagination/paginated_notifier.dart';
import 'package:ui_ux/shared/widgets/infinite_list.dart';

import '../../helpers/pump_app.dart';

void main() {
  late int loads;
  late int retries;

  Future<void> pump(
    WidgetTester tester,
    AsyncValue<PaginatedState<int>> value, {
    SliverGridDelegate? grid,
  }) async {
    await tester.pumpApp(
      InfiniteList<int>(
        value: value,
        onLoadMore: () => loads++,
        onRetry: () => retries++,
        gridDelegate: grid,
        emptyMessage: 'Trống',
        itemBuilder: (_, item, _) =>
            SizedBox(height: 50, child: Text('item $item')),
      ),
    );
    await tester.pump(); // post-frame fill check
  }

  setUp(() {
    loads = 0;
    retries = 0;
  });

  testWidgets('first load: spinner', (tester) async {
    await pump(tester, const AsyncLoading());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(loads, 0);
  });

  testWidgets('first page error: message + retry', (tester) async {
    await pump(
      tester,
      const AsyncError(
        ApiException(code: 'NETWORK_ERROR', message: 'x'),
        StackTrace.empty,
      ),
    );
    expect(find.textContaining('Không có kết nối mạng'), findsOneWidget);
    await tester.tap(find.text('Thử lại'));
    expect(retries, 1);
  });

  testWidgets('empty', (tester) async {
    await pump(tester, const AsyncData(PaginatedState<int>()));
    expect(find.text('Trống'), findsOneWidget);
  });

  testWidgets('short first page with more → loads more', (tester) async {
    await pump(
      tester,
      const AsyncData(PaginatedState(items: [1, 2], nextCursor: 'c')),
    );
    expect(loads, greaterThanOrEqualTo(1));
  });

  testWidgets('last page → never loads more', (tester) async {
    await pump(tester, const AsyncData(PaginatedState(items: [1, 2])));
    expect(loads, 0);
  });

  testWidgets('load-more error: footer retry, no auto loop', (tester) async {
    await pump(
      tester,
      const AsyncData(
        PaginatedState(
          items: [1, 2],
          nextCursor: 'c',
          loadMoreError: ApiException(code: 'TIMEOUT', message: 'x'),
        ),
      ),
    );
    expect(loads, 0);
    expect(find.text('item 1'), findsOneWidget);
    expect(find.textContaining('Kết nối quá chậm'), findsOneWidget);
    await tester.tap(find.text('Thử lại'));
    expect(loads, 1);
  });

  testWidgets('loading more: footer spinner, no duplicate', (tester) async {
    await pump(
      tester,
      const AsyncData(
        PaginatedState(items: [1], nextCursor: 'c', isLoadingMore: true),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(loads, 0);
  });

  testWidgets('long list loads only near the end', (tester) async {
    await pump(
      tester,
      AsyncData(
        PaginatedState(items: List.generate(100, (i) => i), nextCursor: 'c'),
      ),
    );
    expect(loads, 0);
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -4800));
    await tester.pump();
    expect(loads, greaterThan(0));
  });

  testWidgets('grid mode renders items', (tester) async {
    await pump(
      tester,
      const AsyncData(PaginatedState(items: [1, 2, 3])),
      grid: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
    expect(find.byType(SliverGrid), findsOneWidget);
    expect(find.text('item 3'), findsOneWidget);
  });
}
