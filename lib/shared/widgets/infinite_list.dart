import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_ux/core/error/error_messages.dart';
import 'package:ui_ux/core/pagination/paginated_notifier.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';
import 'package:ui_ux/shared/widgets/empty_view.dart';
import 'package:ui_ux/shared/widgets/error_view.dart';

/// Cursor-paginated list/grid fed by a `PaginatedNotifier` state.
///
/// ```dart
/// final reviews = ref.watch(distributorReviewsProvider(id));
/// InfiniteList(
///   value: reviews,
///   onLoadMore: ref.read(distributorReviewsProvider(id).notifier).loadMore,
///   onRetry: () => ref.invalidate(distributorReviewsProvider(id)),
///   onRefresh: () => ref.refresh(distributorReviewsProvider(id).future),
///   itemBuilder: (context, review, index) => ReviewItem(review: review),
///   emptyMessage: 'Chưa có đánh giá',
/// );
/// ```
/// Loads the next page when the user scrolls within [loadMoreThreshold] of
/// the end, and also when the first page doesn't fill the screen.
/// States: first load → spinner; first-page error → [ErrorView] + retry;
/// no items → [EmptyView]; load-more → footer spinner; load-more error →
/// compact footer retry (items stay visible).
class InfiniteList<T> extends StatefulWidget {
  const InfiniteList({
    required this.value,
    required this.itemBuilder,
    required this.onLoadMore,
    super.key,
    this.onRetry,
    this.onRefresh,
    this.emptyMessage = 'Chưa có dữ liệu',
    this.emptyIcon = Icons.inbox_outlined,
    this.header,
    this.separator,
    this.gridDelegate,
    this.padding = const EdgeInsets.all(AppSpacing.page),
    this.controller,
    this.loadMoreThreshold = 400,
  });

  final AsyncValue<PaginatedState<T>> value;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final VoidCallback onLoadMore;

  /// Retry after a first-page error.
  final VoidCallback? onRetry;

  /// Enables pull-to-refresh.
  final Future<void> Function()? onRefresh;
  final String emptyMessage;
  final IconData emptyIcon;

  /// Scrolls with the list, above the items (filters, summary).
  final Widget? header;

  /// Between list items (ignored for grids).
  final Widget? separator;

  /// Set to render a grid (product cards) instead of a list.
  final SliverGridDelegate? gridDelegate;
  final EdgeInsetsGeometry padding;

  /// Pass to scroll programmatically (e.g. to a tapped map marker's item).
  final ScrollController? controller;
  final double loadMoreThreshold;

  @override
  State<InfiniteList<T>> createState() => _InfiniteListState<T>();
}

class _InfiniteListState<T> extends State<InfiniteList<T>> {
  ScrollController? _ownController;

  ScrollController get _controller =>
      widget.controller ?? (_ownController ??= ScrollController());

  @override
  void initState() {
    super.initState();
    _controller.addListener(_maybeLoadMore);
  }

  @override
  void didUpdateWidget(InfiniteList<T> old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      (old.controller ?? _ownController)?.removeListener(_maybeLoadMore);
      _controller.addListener(_maybeLoadMore);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_maybeLoadMore);
    _ownController?.dispose();
    super.dispose();
  }

  void _maybeLoadMore() {
    final state = widget.value.value;
    if (state == null || widget.value.isLoading) return;
    if (!state.hasMore || state.isLoadingMore || state.loadMoreError != null) {
      return;
    }
    if (!_controller.hasClients) return;
    if (_controller.position.extentAfter < widget.loadMoreThreshold) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Content shorter than the viewport never scrolls: check after layout.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _maybeLoadMore();
    });

    final data = widget.value.value;
    final header = widget.header;
    final scrollView = CustomScrollView(
      controller: _controller,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        if (header != null) SliverToBoxAdapter(child: header),
        if (data == null)
          SliverFillRemaining(hasScrollBody: false, child: _firstPageState())
        else if (data.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyView(
              message: widget.emptyMessage,
              icon: widget.emptyIcon,
            ),
          )
        else ...[
          SliverPadding(padding: widget.padding, sliver: _items(data.items)),
          SliverToBoxAdapter(child: _footer(data)),
        ],
      ],
    );

    final onRefresh = widget.onRefresh;
    return onRefresh == null
        ? scrollView
        : RefreshIndicator(onRefresh: onRefresh, child: scrollView);
  }

  Widget _firstPageState() {
    final value = widget.value;
    if (value.hasError && !value.isLoading) {
      return ErrorView(
        message: errorMessageOf(value.error),
        onRetry: widget.onRetry,
      );
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _items(List<T> items) {
    Widget build(BuildContext context, int index) =>
        widget.itemBuilder(context, items[index], index);

    final grid = widget.gridDelegate;
    if (grid != null) {
      return SliverGrid.builder(
        gridDelegate: grid,
        itemCount: items.length,
        itemBuilder: build,
      );
    }
    final separator = widget.separator;
    if (separator != null) {
      return SliverList.separated(
        itemCount: items.length,
        itemBuilder: build,
        separatorBuilder: (_, _) => separator,
      );
    }
    return SliverList.builder(itemCount: items.length, itemBuilder: build);
  }

  Widget _footer(PaginatedState<T> data) {
    final error = data.loadMoreError;
    if (error != null) {
      return ErrorView(
        message: errorMessageOf(error),
        onRetry: widget.onLoadMore,
        compact: true,
      );
    }
    if (data.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return const SizedBox(height: AppSpacing.lg);
  }
}
