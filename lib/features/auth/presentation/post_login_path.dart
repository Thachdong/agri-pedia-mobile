import 'package:ui_ux/core/router/routes.dart';
import 'package:ui_ux/features/auth/domain/models/current_user.dart';
import 'package:ui_ux/shared/enums/user_role.dart';

/// Query parameter carrying the page to return to after login
/// (`/auth/login?from=/x`).
const loginFromParam = 'from';

/// Where a logged-in [user] goes after login (mirrors web
/// getPostLoginPath): [from] when it is a safe in-app path, otherwise
/// DISTRIBUTOR → their profile, FARMER → home.
String postLoginPath(CurrentUser user, String? from) =>
    safeFromPath(from) ??
    switch (user.role) {
      UserRole.distributor => Routes.profile(user.id),
      UserRole.farmer => Routes.home,
    };

/// [from] if it is an in-app path, else null. Rejects external URLs
/// (`http:`, `//host`, `/\host`) and /auth/* (would loop back to login).
String? safeFromPath(String? from) {
  if (from == null || !from.startsWith('/') || from.startsWith('//')) {
    return null;
  }
  if (from.contains(r'\')) return null;
  final uri = Uri.tryParse(from);
  if (uri == null || uri.hasScheme || uri.hasAuthority) return null;
  if (uri.path == '/auth' || uri.path.startsWith('/auth/')) return null;
  return from;
}
