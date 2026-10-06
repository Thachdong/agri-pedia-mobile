import 'package:flutter/material.dart';
import 'package:ui_ux/features/auth/presentation/widgets/activate_form.dart';
import 'package:ui_ux/features/auth/presentation/widgets/auth_footer_links.dart';
import 'package:ui_ux/features/auth/presentation/widgets/auth_scaffold.dart';

/// /auth/activate (public) — wireframe specs/ui-ux/image-1.png:
/// (1) AuthHeader, (2) title + EMAIL | PHONE tabs, (3) identifier, code,
/// resend + countdown, (4) ACTIVATE + footer links. Handoff init, focus,
/// resend, cleanup and redirect live in [ActivateForm] / its controllers.
class ActivatePage extends StatelessWidget {
  const ActivatePage({super.key});

  @override
  Widget build(BuildContext context) => const AuthScaffold(
    title: 'Activate Account',
    footer: AuthFooterLinks(
      links: [AuthLink.register, AuthLink.login, AuthLink.resetPassword],
    ),
    child: ActivateForm(),
  );
}
