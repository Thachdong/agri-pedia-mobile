import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/app/router/auth_redirect.dart';
import 'package:ui_ux/core/router/routes.dart';
import 'package:ui_ux/features/auth/auth.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // Bridges the session to go_router: a change re-runs [authRedirect]
  // without rebuilding the router.
  final auth = ValueNotifier<AuthState?>(ref.read(authStateProvider).value);
  ref.listen(authStateProvider, (_, next) => auth.value = next.value);

  final router = GoRouter(
    initialLocation: Routes.home,
    debugLogDiagnostics: false,
    refreshListenable: auth,
    redirect: (context, state) => authRedirect(auth.value, state.uri),
    routes: [
      // TODO(distributor): replace with the home page ("/").
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const _PlaceholderPage(
          title: 'AgriPedia',
          links: {
            'Đăng nhập': Routes.login,
            'Đăng ký': Routes.register,
            'Kích hoạt': Routes.activate,
          },
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
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.resetPassword,
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: Routes.changePassword,
        builder: (context, state) => const ChangePasswordPage(),
      ),
      // TODO(profile): replace with the profile page (DISTRIBUTOR lands here
      // after login).
      GoRoute(
        path: Routes.profilePattern,
        builder: (context, state) => _PlaceholderPage(
          title: 'Profile ${state.pathParameters['profileId']}',
        ),
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    auth.dispose();
  });
  return router;
}

/// Temporary screen for routes whose feature page doesn't exist yet. Shows
/// the logged-in user + a logout button so the auth flow can be retested.
class _PlaceholderPage extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$title (đang phát triển)'),
            if (user != null) ...[
              Text('Đã đăng nhập: ${user.username} (${user.role.label})'),
              TextButton(
                onPressed: () => ref.read(authStateProvider.notifier).logout(),
                child: const Text('Đăng xuất'),
              ),
            ],
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
}
