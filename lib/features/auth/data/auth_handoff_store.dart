import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/storage/key_value_storage.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/login_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';

part 'auth_handoff_store.g.dart';

/// Persists [AuthHandoff] through [KeyValueStorage], one key per purpose,
/// plus the [LoginHandoff] for /auth/login. Never passed through route
/// `extra`.
class AuthHandoffStore {
  AuthHandoffStore(this._storage);

  final KeyValueStorage _storage;

  static String _key(OtpPurpose purpose) => 'auth_handoff.${purpose.value}';

  Future<void> save(AuthHandoff handoff) =>
      _storage.setJson(_key(handoff.purpose), handoff.toJson());

  /// Null when absent; an unreadable value is removed and treated as absent.
  Future<AuthHandoff?> read(OtpPurpose purpose) async {
    final json = await _storage.getJson(_key(purpose));
    if (json == null) return null;
    try {
      final handoff = AuthHandoff.fromJson(json);
      if (handoff.purpose == purpose && handoff.identifier.isNotEmpty) {
        return handoff;
      }
    } on Object catch (_) {
      // Malformed (old shape, wrong types): fall through and drop it.
    }
    await clear(purpose);
    return null;
  }

  /// Called after the flow succeeds (activate / change-password).
  Future<void> clear(OtpPurpose purpose) => _storage.remove(_key(purpose));

  static const _loginKey = 'auth_handoff.LOGIN';

  Future<void> saveLogin(LoginHandoff handoff) =>
      _storage.setJson(_loginKey, handoff.toJson());

  /// Null when absent; an unreadable value is removed and treated as absent.
  Future<LoginHandoff?> readLogin() async {
    final json = await _storage.getJson(_loginKey);
    if (json == null) return null;
    try {
      final handoff = LoginHandoff.fromJson(json);
      if (handoff.identifier.isNotEmpty) return handoff;
    } on Object catch (_) {
      // Malformed: fall through and drop it.
    }
    await clearLogin();
    return null;
  }

  /// Called after login succeeds.
  Future<void> clearLogin() => _storage.remove(_loginKey);
}

@Riverpod(keepAlive: true)
AuthHandoffStore authHandoffStore(Ref ref) =>
    AuthHandoffStore(ref.watch(keyValueStorageProvider));
