import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'key_value_storage.g.dart';

/// Small persistent JSON store (handoff data, UI preferences).
/// Never store tokens here — use `TokenStorage`.
class KeyValueStorage {
  KeyValueStorage(this._prefs);

  static const _prefix = 'agripedia.';

  final SharedPreferencesAsync _prefs;

  /// Null when absent or unreadable (corrupt values are removed).
  Future<Map<String, Object?>?> getJson(String key) async {
    final raw = await _prefs.getString('$_prefix$key');
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, Object?>;
    } on FormatException {
      await remove(key);
      return null;
    } on TypeError {
      await remove(key);
      return null;
    }
  }

  Future<void> setJson(String key, Map<String, Object?> value) =>
      _prefs.setString('$_prefix$key', jsonEncode(value));

  Future<void> remove(String key) => _prefs.remove('$_prefix$key');
}

@Riverpod(keepAlive: true)
KeyValueStorage keyValueStorage(Ref ref) =>
    KeyValueStorage(SharedPreferencesAsync());
