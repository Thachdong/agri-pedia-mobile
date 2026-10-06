/// One page of a cursor-paginated endpoint.
///
/// Server shape: `{ <itemsKey>: [...], nextCursor: string | null }` — the list
/// key differs per endpoint (`reviews`, `products`, `distributors`...).
class CursorPage<T> {
  const CursorPage({required this.items, this.nextCursor});

  factory CursorPage.fromJson(
    Object? json,
    String itemsKey,
    T Function(Map<String, Object?> json) fromItem,
  ) {
    final map = json! as Map<String, Object?>;
    final raw = map[itemsKey]! as List<Object?>;
    return CursorPage(
      items: [for (final item in raw) fromItem(item! as Map<String, Object?>)],
      nextCursor: map['nextCursor'] as String?,
    );
  }

  final List<T> items;

  /// Pass back as `cursor` with the same filters; null on the last page.
  final String? nextCursor;

  bool get hasMore => nextCursor != null;
}
