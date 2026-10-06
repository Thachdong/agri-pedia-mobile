import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/app/router/routes.dart';

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
        builder: (context, state) => const _PlaceholderPage(),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
}

/// Temporary screen until the first feature page exists.
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage();

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('AgriPedia')));
}
