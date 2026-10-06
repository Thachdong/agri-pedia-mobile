import 'package:flutter/material.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';

/// Visual style, mirroring the web classes.
enum AppButtonVariant {
  /// `.btn-normal`: filled primary. Main action of a form (LOGIN, RESET).
  primary,

  /// `.btn-highlight`: filled highlight. Emphasized secondary action.
  highlight,

  /// Primary outline. Secondary action next to a primary one (Chat).
  outline,

  /// Text only, highlight color. Inline links (footer, "Back To Home").
  text,
}

enum AppButtonSize { regular, small }

/// The app's button. Styling comes from the theme (app_theme.dart);
/// this widget only picks the variant and handles loading / disabled.
///
/// `onPressed == null` or `isLoading` → disabled. While loading the label is
/// replaced by a spinner of the same height, so the button keeps its size.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.regular,
    this.icon,
    this.isLoading = false,
    this.expand = false,
    this.focusNode,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final bool isLoading;

  /// Full available width (form submit buttons on narrow screens).
  final bool expand;

  /// Lets a form move focus here (e.g. after the last OTP box).
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final onTap = isLoading ? null : onPressed;
    final child = _ButtonContent(
      label: label,
      icon: icon,
      isLoading: isLoading,
      spinnerColor: _foreground(context),
    );
    final style = _style(context);

    final button = switch (variant) {
      AppButtonVariant.primary || AppButtonVariant.highlight => FilledButton(
        onPressed: onTap,
        focusNode: focusNode,
        style: style,
        child: child,
      ),
      AppButtonVariant.outline => OutlinedButton(
        onPressed: onTap,
        focusNode: focusNode,
        style: style,
        child: child,
      ),
      AppButtonVariant.text => TextButton(
        onPressed: onTap,
        focusNode: focusNode,
        style: style,
        child: child,
      ),
    };

    return Semantics(
      button: true,
      enabled: onTap != null,
      label: isLoading ? '$label, đang xử lý' : null,
      child: expand ? SizedBox(width: double.infinity, child: button) : button,
    );
  }

  ButtonStyle? _style(BuildContext context) {
    final small = size == AppButtonSize.small
        ? ButtonStyle(
            visualDensity: VisualDensity.compact,
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
            ),
            textStyle: WidgetStatePropertyAll(context.text.labelMedium),
          )
        : null;

    if (variant != AppButtonVariant.highlight) return small;

    final colors = context.colors;
    final highlight = FilledButton.styleFrom(
      backgroundColor: colors.highlight,
      foregroundColor: colors.onHighlight,
      disabledBackgroundColor: colors.highlight.withValues(alpha: 0.4),
      disabledForegroundColor: colors.onHighlight,
    );
    return small == null ? highlight : highlight.merge(small);
  }

  Color _foreground(BuildContext context) => switch (variant) {
    AppButtonVariant.primary => context.scheme.onPrimary,
    AppButtonVariant.highlight => context.colors.onHighlight,
    AppButtonVariant.outline => context.scheme.primary,
    AppButtonVariant.text => context.colors.highlight,
  };
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.icon,
    required this.isLoading,
    required this.spinnerColor,
  });

  final String label;
  final IconData? icon;
  final bool isLoading;
  final Color spinnerColor;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox.square(
        dimension: AppSpacing.lg,
        child: CircularProgressIndicator(strokeWidth: 2, color: spinnerColor),
      );
    }
    final text = Text(label, maxLines: 1, overflow: TextOverflow.ellipsis);
    if (icon == null) return text;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: AppSpacing.lg + AppSpacing.xxs),
        const SizedBox(width: AppSpacing.sm),
        Flexible(child: text),
      ],
    );
  }
}
