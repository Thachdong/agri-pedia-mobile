import 'package:flutter/material.dart';
import 'package:ui_ux/features/auth/presentation/widgets/auth_footer_links.dart';
import 'package:ui_ux/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:ui_ux/features/auth/presentation/widgets/login_form.dart';

/// /auth/login (public, guest only) — wireframe specs/ui-ux/image-2.png:
/// (1) AuthHeader, (2) title + EMAIL | PHONE tabs, (3) identifier +
/// password, (4) LOGIN + footer links. Init and submit live in [LoginForm];
/// after login the router guard leaves this page (`?from=` or by role).
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => const AuthScaffold(
    title: 'Login',
    footer: AuthFooterLinks(
      links: [AuthLink.register, AuthLink.activate, AuthLink.resetPassword],
    ),
    child: LoginForm(),
  );
}
