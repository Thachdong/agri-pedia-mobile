import 'package:flutter/material.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';

/// Failed load with a retry. The caller passes `errorMessageOf(error)` and
/// retries with `ref.invalidate(...)` / `notifier.loadMore()`.
///
/// [compact] renders one row (list footer after a failed "load more").
class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.message,
    super.key,
    this.onRetry,
    this.compact = false,
  });

  final String message;
  final VoidCallback? onRetry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final retry = onRetry == null
        ? null
        : AppButton(
            label: 'Thử lại',
            onPressed: onRetry,
            variant: compact ? AppButtonVariant.text : AppButtonVariant.outline,
            size: compact ? AppButtonSize.small : AppButtonSize.regular,
            icon: Icons.refresh,
          );

    if (compact) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: context.text.bodySmall?.copyWith(
                  color: context.scheme.error,
                ),
              ),
            ),
            ?retry,
          ],
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: AppSpacing.xxxl,
              color: context.scheme.error,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.text.bodyMedium,
            ),
            if (retry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              retry,
            ],
          ],
        ),
      ),
    );
  }
}
