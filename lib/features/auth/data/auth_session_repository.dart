import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/network/api_client.dart';
import 'package:ui_ux/core/storage/token_storage.dart';
import 'package:ui_ux/features/auth/data/auth_api.dart';
import 'package:ui_ux/features/auth/data/dtos/user_profile_dto.dart';
import 'package:ui_ux/features/auth/domain/models/current_user.dart';

part 'auth_session_repository.g.dart';

/// Session persistence: tokens (TokenStorage) + who is logged in
/// (GET /users/me). Refresh / expiry is handled by the AuthInterceptor.
class AuthSessionRepository {
  AuthSessionRepository(this._api, this._tokens);

  final AuthApi _api;
  final TokenStorage _tokens;

  /// User of the stored session, or null (no token, or /users/me failed —
  /// e.g. refresh rejected, which already cleared the tokens, or offline,
  /// which keeps them for the next start).
  Future<CurrentUser?> restore() async {
    try {
      if (await _tokens.read() == null) return null;
      return currentUserFromDto(await _api.me());
    } on Object {
      return null;
    }
  }

  Future<void> saveTokens(TokenPair tokens) => _tokens.write(tokens);

  /// Revokes the session server side (best effort: the user is logged out
  /// locally even if the call fails), then forgets the tokens.
  Future<void> logout() async {
    try {
      final tokens = await _tokens.read();
      if (tokens != null) await _api.logout(tokens.refreshToken);
    } on Object {
      // Offline or token already invalid: nothing more to revoke.
    } finally {
      await _tokens.clear();
    }
  }
}

CurrentUser currentUserFromDto(UserProfileDto dto) => CurrentUser(
  id: dto.id,
  loginType: dto.loginType,
  identifier: dto.email ?? dto.phone ?? '',
  username: dto.username,
  role: dto.role,
  businessType: dto.bussinessType,
  avatar: dto.avatar,
  bio: dto.bio,
);

@Riverpod(keepAlive: true)
AuthSessionRepository authSessionRepository(Ref ref) => AuthSessionRepository(
  AuthApi(ref.watch(apiClientProvider)),
  ref.watch(tokenStorageProvider),
);
