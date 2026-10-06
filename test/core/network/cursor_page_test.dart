import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/network/cursor_page.dart';

void main() {
  String id(Map<String, Object?> json) => json['id']! as String;

  test('reads items from the endpoint list key + nextCursor', () {
    final page = CursorPage.fromJson(
      {
        'reviews': [
          {'id': 'r1'},
          {'id': 'r2'},
        ],
        'nextCursor': 'abc',
        'summary': {'avgRating': 4.5},
      },
      'reviews',
      id,
    );
    expect(page.items, ['r1', 'r2']);
    expect(page.nextCursor, 'abc');
    expect(page.hasMore, isTrue);
  });

  test('last page: nextCursor null → hasMore false', () {
    final page = CursorPage.fromJson(
      {'products': <Object?>[], 'nextCursor': null},
      'products',
      id,
    );
    expect(page.items, isEmpty);
    expect(page.hasMore, isFalse);
  });

  test('wrong list key throws (ApiClient maps it to INVALID_RESPONSE)', () {
    expect(
      () => CursorPage.fromJson(
        {'items': <Object?>[], 'nextCursor': null},
        'reviews',
        id,
      ),
      throwsA(isA<TypeError>()),
    );
  });
}
