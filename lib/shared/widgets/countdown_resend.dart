import 'package:flutter/material.dart';
import 'package:ui_ux/core/utils/formatters.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';

/// "Gửi lại mã" link under the code input (activate, change-password).
///
/// Counting ([remaining] > 0): disabled, shows "Gửi lại mã (mm:ss)".
/// Otherwise enabled, no countdown. [remaining] comes from
/// `countdownControllerProvider(id)`; the page restarts it after resending.
class CountdownResend extends StatelessWidget {
  const CountdownResend({
    required this.remaining,
    required this.onResend,
    super.key,
    this.isSending = false,
  });

  final Duration remaining;
  final VoidCallback? onResend;
  final bool isSending;

  @override
  Widget build(BuildContext context) {
    final counting = remaining > Duration.zero;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            'Chưa nhận được mã?',
            style: context.text.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        AppButton(
          label: counting
              ? 'Gửi lại mã (${Formatters.countdown(remaining)})'
              : 'Gửi lại mã',
          onPressed: counting ? null : onResend,
          isLoading: isSending,
          variant: AppButtonVariant.text,
          size: AppButtonSize.small,
        ),
      ],
    );
  }
}
