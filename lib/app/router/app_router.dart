import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/router/routes.dart';
import 'package:ui_ux/features/auth/auth.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final router = GoRouter(
    initialLocation: Routes.home,
    debugLogDiagnostics: false,
    routes: [
      // TODO(distributor): replace with the home page ("/").
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const _PlaceholderPage(
          title: 'AgriPedia',
          links: {'Đăng ký': Routes.register, 'Kích hoạt': Routes.activate},
          showHomeLink: false,
        ),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: Routes.activate,
        builder: (context, state) => const ActivatePage(),
      ),
      // TODO(auth-login): replace with LoginPage.
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const _PlaceholderPage(title: 'Đăng nhập'),
      ),
      GoRoute(
        path: Routes.resetPassword,
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: Routes.changePassword,
        builder: (context, state) => const ChangePasswordPage(),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
}

/// Temporary screen for routes whose feature page doesn't exist yet.
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({
    required this.title,
    this.links = const {},
    this.showHomeLink = true,
  });

  final String title;
  final bool showHomeLink;

  /// Button label → path, to reach built pages during development.
  final Map<String, String> links;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$title (đang phát triển)'),
          for (final MapEntry(key: label, value: path) in links.entries)
            TextButton(onPressed: () => context.go(path), child: Text(label)),
          if (showHomeLink)
            TextButton(
              onPressed: () => context.go(Routes.home),
              child: const Text('Về trang chủ'),
            ),
        ],
      ),
    ),
  );
}
