import 'package:flutter/material.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';

/// Opens a modal bottom sheet (modals M1–M10) with the app's sheet layout:
/// drag handle, [title] + close button, content that stays above the
/// keyboard and scrolls when long. Resolves with the value passed to
/// `Navigator.pop(context, value)` (e.g. `true` after a successful submit).
///
/// [fullHeight]: fixed 90% height for sheets that own their scrolling
/// (chat: message list + input). The content then gets the remaining space
/// and is not wrapped in a scroll view.
Future<T?> showAppSheet<T>(
  BuildContext context, {
  required String title,
  required WidgetBuilder builder,
  bool fullHeight = false,
  bool isDismissible = true,
}) => showModalBottomSheet<T>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  isDismissible: isDismissible,
  enableDrag: isDismissible,
  builder: (context) =>
      _AppSheet(title: title, fullHeight: fullHeight, child: builder(context)),
);

class _AppSheet extends StatelessWidget {
  const _AppSheet({
    required this.title,
    required this.fullHeight,
    required this.child,
  });

  static const _fullHeightFactor = 0.9;

  final String title;
  final bool fullHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    final header = Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.page,
        right: AppSpacing.xs,
      ),
      child: Row(
        children: [
          Expanded(child: Text(title, style: context.text.titleLarge)),
          IconButton(
            tooltip: 'Đóng',
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
    );
    const contentPadding = EdgeInsets.fromLTRB(
      AppSpacing.page,
      AppSpacing.sm,
      AppSpacing.page,
      AppSpacing.xl,
    );

    // Route semantics come from the modal route itself.
    return Padding(
      padding: EdgeInsets.only(bottom: keyboard),
      child: fullHeight
          ? SizedBox(
              height: MediaQuery.sizeOf(context).height * _fullHeightFactor,
              child: Column(
                children: [
                  header,
                  Expanded(
                    child: Padding(padding: contentPadding, child: child),
                  ),
                ],
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                header,
                Flexible(
                  child: SingleChildScrollView(
                    padding: contentPadding,
                    child: child,
                  ),
                ),
              ],
            ),
    );
  }
}
