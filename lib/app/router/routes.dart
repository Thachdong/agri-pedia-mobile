/// Route paths (specs/ui-ux/ui-ux.md). Navigate with these, never literals.
abstract final class Routes {
  static const home = '/';

  static const register = '/auth/register';
  static const activate = '/auth/activate';
  static const login = '/auth/login';
  static const resetPassword = '/auth/reset-password';
  static const changePassword = '/auth/change-password';

  static const profilePattern = '/profile/:profileId';
  static String profile(String profileId) => '/profile/$profileId';

  /// Routes that need login; the auth redirect (mb-auth-session) guards them.
  /// Spec pages so far are all public.
  static const privatePrefixes = <String>[];
}
