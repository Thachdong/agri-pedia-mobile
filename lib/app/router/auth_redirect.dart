import 'package:ui_ux/core/router/routes.dart';
import 'package:ui_ux/features/auth/auth.dart';

/// go_router redirect for the session (mb-auth-session):
/// - session still loading ([auth] null) → stay;
/// - logged in on /auth/* → where login leads ([postLoginPath]: safe `from`
///   query, else by role). This is also how a successful login navigates;
/// - guest on a private route → `/auth/login?from=<location>`.
String? authRedirect(AuthState? auth, Uri location) {
  final path = location.path;
  return switch (auth) {
    Authenticated(:final user) when _isAuthRoute(path) => postLoginPath(
      user,
      location.queryParameters[loginFromParam],
    ),
    Guest() when Routes.isPrivate(path) => Uri(
      path: Routes.login,
      queryParameters: {loginFromParam: location.toString()},
    ).toString(),
    _ => null,
  };
}

bool _isAuthRoute(String path) => path == '/auth' || path.startsWith('/auth/');
