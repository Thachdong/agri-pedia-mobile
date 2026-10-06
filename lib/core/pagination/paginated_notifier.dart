import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/network/cursor_page.dart';

/// Accumulated items of an infinite list.
@immutable
class PaginatedState<T> {
  const PaginatedState({
    this.items = const [],
    this.nextCursor,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<T> items;
  final String? nextCursor;
  final bool isLoadingMore;

  /// Error of the last [PaginatedNotifier.loadMore]; the list stays visible.
  final Object? loadMoreError;

  bool get hasMore => nextCursor != null;
  bool get isEmpty => items.isEmpty;

  PaginatedState<T> copyWith({
    List<T>? items,
    String? nextCursor,
    bool? isLoadingMore,
    Object? loadMoreError,
    bool clearNextCursor = false,
    bool clearLoadMoreError = false,
  }) => PaginatedState(
    items: items ?? this.items,
    nextCursor: clearNextCursor ? null : (nextCursor ?? this.nextCursor),
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    loadMoreError: clearLoadMoreError
        ? null
        : (loadMoreError ?? this.loadMoreError),
  );
}

/// Cursor pagination for an async notifier.
///
/// ```dart
/// @riverpod
/// class DistributorReviews extends _$DistributorReviews
///     with PaginatedNotifier<Review> {
///   @override
///   Future<PaginatedState<Review>> build(String distributorId) =>
///       loadFirstPage();
///
///   @override
///   Future<CursorPage<Review>> fetchPage(String? cursor) => ref
///       .read(reviewRepositoryProvider)
///       .listByDistributor(distributorId, cursor: cursor);
/// }
/// ```
/// First-page errors surface as `AsyncError`; load-more errors stay in
/// [PaginatedState.loadMoreError] so loaded items remain on screen.
mixin PaginatedNotifier<T>
    on AnyNotifier<AsyncValue<PaginatedState<T>>, PaginatedState<T>> {
  /// Fetches one page; `cursor` is null for the first page.
  Future<CursorPage<T>> fetchPage(String? cursor);

  /// Call from `build`.
  Future<PaginatedState<T>> loadFirstPage() async {
    final page = await fetchPage(null);
    return PaginatedState(items: page.items, nextCursor: page.nextCursor);
  }

  /// Appends the next page. No-op while loading, on error or on the last page.
  Future<void> loadMore() async {
    final current = state.value;
    if (state.isLoading || current == null) return;
    if (!current.hasMore || current.isLoadingMore) return;

    // The notifier instance survives rebuilds and `ref` always returns the
    // latest Ref, so capture this build's Ref: after a refresh() it is no
    // longer mounted and the stale page must be dropped.
    final buildRef = ref;
    state = AsyncData(
      current.copyWith(isLoadingMore: true, clearLoadMoreError: true),
    );
    try {
      final page = await fetchPage(current.nextCursor);
      if (!buildRef.mounted) return;
      // Append to the latest items: updateItems may have run meanwhile.
      final latest = state.value ?? current;
      state = AsyncData(
        PaginatedState(
          items: [...latest.items, ...page.items],
          nextCursor: page.nextCursor,
        ),
      );
    } catch (e) {
      if (!buildRef.mounted) return;
      final latest = state.value ?? current;
      state = AsyncData(
        latest.copyWith(isLoadingMore: false, loadMoreError: e),
      );
    }
  }

  /// Reloads from the first page, keeping current items visible meanwhile.
  void refresh() => ref.invalidateSelf();

  /// Local edit of loaded items (realtime push, optimistic update).
  void updateItems(List<T> Function(List<T> items) update) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(items: update(current.items)));
  }
}
