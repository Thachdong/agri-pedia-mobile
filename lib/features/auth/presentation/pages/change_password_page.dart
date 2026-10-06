import 'package:flutter/material.dart';
import 'package:ui_ux/features/auth/presentation/widgets/auth_footer_links.dart';
import 'package:ui_ux/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:ui_ux/features/auth/presentation/widgets/change_password_form.dart';

/// /auth/change-password (public) — wireframe specs/ui-ux/image-7.png:
/// (1) AuthHeader, (2) title + EMAIL | PHONE tabs, (3) identifier, password,
/// confirm password, code, resend + countdown, (4) CHANGE PASSWORD + footer
/// links. Handoff init, focus, resend, cleanup and redirect live in
/// [ChangePasswordForm] / its controllers.
class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) => const AuthScaffold(
    title: 'Change Password',
    footer: AuthFooterLinks(links: [AuthLink.register, AuthLink.login]),
    child: ChangePasswordForm(),
  );
}
