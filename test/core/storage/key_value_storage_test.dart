import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:ui_ux/core/storage/key_value_storage.dart';

void main() {
  late SharedPreferencesAsync prefs;
  late KeyValueStorage storage;

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    prefs = SharedPreferencesAsync();
    storage = KeyValueStorage(prefs);
  });

  test('setJson / getJson round trip under the app prefix', () async {
    await storage.setJson('handoff.ACTIVATE_DISTRIBUTOR', {
      'identifier': 'a@b.vn',
      'at': '2026-10-06T10:00:00.000Z',
    });

    expect(await storage.getJson('handoff.ACTIVATE_DISTRIBUTOR'), {
      'identifier': 'a@b.vn',
      'at': '2026-10-06T10:00:00.000Z',
    });
    expect(
      await prefs.getString('agripedia.handoff.ACTIVATE_DISTRIBUTOR'),
      isNotNull,
    );
  });

  test('missing key → null', () async {
    expect(await storage.getJson('nope'), isNull);
  });

  test('corrupt or non-object value → null and removed', () async {
    await prefs.setString('agripedia.bad', '{not json');
    await prefs.setString('agripedia.list', '[1,2]');

    expect(await storage.getJson('bad'), isNull);
    expect(await storage.getJson('list'), isNull);
    expect(await prefs.getString('agripedia.bad'), isNull);
    expect(await prefs.getString('agripedia.list'), isNull);
  });

  test('remove deletes the key', () async {
    await storage.setJson('k', {'a': 1});
    await storage.remove('k');
    expect(await storage.getJson('k'), isNull);
  });
}
