import 'package:flutter/material.dart';
import 'package:ui_ux/features/auth/presentation/widgets/auth_footer_links.dart';
import 'package:ui_ux/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:ui_ux/features/auth/presentation/widgets/reset_password_form.dart';

/// /auth/reset-password (public) — wireframe specs/ui-ux/image-3.png:
/// (1) AuthHeader, (2) title + EMAIL | PHONE tabs, (3) identifier,
/// (4) RESET + footer links. Focus, submit, handoff and redirect live in
/// [ResetPasswordForm] / its controller.
class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) => const AuthScaffold(
    title: 'Reset Password',
    footer: AuthFooterLinks(
      links: [AuthLink.register, AuthLink.login, AuthLink.activate],
    ),
    child: ResetPasswordForm(),
  );
}
