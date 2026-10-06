import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/storage/key_value_storage.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';

part 'auth_handoff_store.g.dart';

/// Persists [AuthHandoff] through [KeyValueStorage], one key per purpose.
/// Never passed through route `extra`.
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
}

@Riverpod(keepAlive: true)
AuthHandoffStore authHandoffStore(Ref ref) =>
    AuthHandoffStore(ref.watch(keyValueStorageProvider));
