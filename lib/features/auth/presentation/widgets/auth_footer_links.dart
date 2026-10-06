import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_ux/core/router/routes.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/theme/app_spacing.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';

/// One footer link of the auth pages (ui-ux.md section (4)).
enum AuthLink {
  register('Bạn chưa có account?', 'Đăng ký', Routes.register),
  login('Đã có account?', 'Đăng nhập', Routes.login),
  activate('Account chưa kích hoạt?', 'Kích hoạt', Routes.activate),
  resetPassword('Quên mật khẩu?', 'Reset mật khẩu', Routes.resetPassword);

  const AuthLink(this.question, this.label, this.path);

  final String question;
  final String label;
  final String path;
}

/// Footer links under an auth form; each page picks its [links] in order:
/// register / activate → register, login, resetPassword;
/// login → register, activate, resetPassword;
/// reset-password → register, login, activate.
class AuthFooterLinks extends StatelessWidget {
  const AuthFooterLinks({required this.links, super.key});

  final List<AuthLink> links;

  @override
  Widget build(BuildContext context) {
    final style = context.text.bodyMedium?.copyWith(
      color: context.scheme.onSurfaceVariant,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final link in links)
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSpacing.xs,
            children: [
              Text(link.question, style: style),
              AppButton(
                label: link.label,
                variant: AppButtonVariant.text,
                size: AppButtonSize.small,
                onPressed: () => context.go(link.path),
              ),
            ],
          ),
      ],
    );
  }
}
