import 'package:flutter/material.dart';
import 'package:ui_ux/features/auth/presentation/widgets/auth_footer_links.dart';
import 'package:ui_ux/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:ui_ux/features/auth/presentation/widgets/register_form.dart';

/// /auth/register (public) — wireframe specs/ui-ux/image.png:
/// (1) AuthHeader, (2) title + EMAIL | PHONE tabs, (3) fields (scroll-y),
/// (4) REGISTER + footer links. Init focus, submit, handoff and redirect
/// live in [RegisterForm] / its controller.
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) => const AuthScaffold(
    title: 'Register',
    footer: AuthFooterLinks(
      links: [AuthLink.register, AuthLink.login, AuthLink.resetPassword],
    ),
    child: RegisterForm(),
  );
}
