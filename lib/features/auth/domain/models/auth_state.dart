import 'package:ui_ux/features/auth/domain/models/current_user.dart';

/// Session of the app: guest or logged in (CLAUDE.md decision 8).
sealed class AuthState {
  const AuthState();
}

final class Guest extends AuthState {
  const Guest();
}

final class Authenticated extends AuthState {
  const Authenticated(this.user);

  final CurrentUser user;
}
