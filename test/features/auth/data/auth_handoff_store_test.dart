import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:ui_ux/core/storage/key_value_storage.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/login_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

void main() {
  late SharedPreferencesAsync prefs;
  late AuthHandoffStore store;

  final activate = AuthHandoff(
    loginType: LoginType.phone,
    identifier: '0901234567',
    at: DateTime.utc(2026, 10, 6, 9),
    purpose: OtpPurpose.activateDistributor,
  );

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    prefs = SharedPreferencesAsync();
    store = AuthHandoffStore(KeyValueStorage(prefs));
  });

  test('save → read round trip', () async {
    await store.save(activate);

    expect(await store.read(OtpPurpose.activateDistributor), activate);
    expect(
      await prefs.getString('agripedia.auth_handoff.ACTIVATE_DISTRIBUTOR'),
      isNotNull,
    );
  });

  test('absent → null', () async {
    expect(await store.read(OtpPurpose.activateDistributor), isNull);
  });

  test('one key per purpose; clear removes only that purpose', () async {
    final reset = activate.copyWith(purpose: OtpPurpose.resetPassword);
    await store.save(activate);
    await store.save(reset);

    await store.clear(OtpPurpose.activateDistributor);

    expect(await store.read(OtpPurpose.activateDistributor), isNull);
    expect(await store.read(OtpPurpose.resetPassword), reset);
  });

  test('malformed value → null and removed', () async {
    await prefs.setString(
      'agripedia.auth_handoff.ACTIVATE_DISTRIBUTOR',
      '{"identifier": 1}',
    );

    expect(await store.read(OtpPurpose.activateDistributor), isNull);
    expect(
      await prefs.getString('agripedia.auth_handoff.ACTIVATE_DISTRIBUTOR'),
      isNull,
    );
  });

  test('empty identifier → null and removed', () async {
    await store.save(activate.copyWith(identifier: ''));

    expect(await store.read(OtpPurpose.activateDistributor), isNull);
    expect(
      await prefs.getString('agripedia.auth_handoff.ACTIVATE_DISTRIBUTOR'),
      isNull,
    );
  });

  group('login handoff', () {
    const login = LoginHandoff(
      loginType: LoginType.phone,
      identifier: '0901234567',
    );

    test('saveLogin → readLogin; own key, independent of OTP ones', () async {
      await store.save(activate);
      await store.saveLogin(login);

      expect(await store.readLogin(), login);
      expect(await prefs.getString('agripedia.auth_handoff.LOGIN'), isNotNull);

      await store.clearLogin();
      expect(await store.readLogin(), isNull);
      expect(await store.read(OtpPurpose.activateDistributor), activate);
    });

    test('absent → null', () async {
      expect(await store.readLogin(), isNull);
    });

    test('malformed or empty identifier → null and removed', () async {
      await prefs.setString('agripedia.auth_handoff.LOGIN', '{"x": 1}');
      expect(await store.readLogin(), isNull);
      expect(await prefs.getString('agripedia.auth_handoff.LOGIN'), isNull);

      await store.saveLogin(login.copyWith(identifier: ''));
      expect(await store.readLogin(), isNull);
      expect(await prefs.getString('agripedia.auth_handoff.LOGIN'), isNull);
    });
  });
}
