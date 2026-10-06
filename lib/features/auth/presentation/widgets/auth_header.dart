import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_ux/core/router/routes.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';

/// Header of the auth pages (ui-ux.md section (1)): logo "AgriPedia" and
/// "Back To Home", both going to "/". Used as `Scaffold.appBar`.
class AuthHeader extends StatelessWidget implements PreferredSizeWidget {
  const AuthHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    void goHome() => context.go(Routes.home);
    return AppBar(
      automaticallyImplyLeading: false,
      title: Semantics(
        link: true,
        label: 'AgriPedia, về trang chủ',
        excludeSemantics: true,
        child: InkWell(
          onTap: goHome,
          child: Text(
            'AgriPedia',
            style: context.text.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: scheme.primary,
            ),
          ),
        ),
      ),
      actions: [
        AppButton(
          label: 'Back To Home',
          icon: Icons.arrow_back,
          variant: AppButtonVariant.text,
          size: AppButtonSize.small,
          onPressed: goHome,
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, thickness: 1, color: scheme.outlineVariant),
      ),
    );
  }
}
