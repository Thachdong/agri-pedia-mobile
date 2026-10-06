import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/core/storage/token_storage.dart';
import 'package:ui_ux/features/auth/data/auth_api.dart';
import 'package:ui_ux/features/auth/data/auth_session_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/user_profile_dto.dart';

import '../../../fixtures/auth_fixtures.dart';

class _MockAuthApi extends Mock implements AuthApi {}

void main() {
  late _MockAuthApi api;
  late TokenStorage tokens;
  late AuthSessionRepository repository;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    api = _MockAuthApi();
    tokens = TokenStorage(const FlutterSecureStorage());
    repository = AuthSessionRepository(api, tokens);
  });

  test('UserProfileDto parses spec names; mapped to CurrentUser', () {
    final dto = UserProfileDto.fromJson(userProfileJson());

    expect(dto.bussinessLicense, startsWith('https://'));
    expect(dto.address?.province, 'ha_noi');
    expect(currentUserFromDto(dto), distributorUser);
    expect(
      currentUserFromDto(
        UserProfileDto.fromJson({
          ...userProfileJson(role: 'FARMER'),
          'loginType': 'EMAIL',
          'email': 'a@b.vn',
          'phone': null,
          'address': null,
        }),
      ).identifier,
      'a@b.vn',
    );
  });

  group('restore', () {
    test('no tokens → null, no /users/me', () async {
      expect(await repository.restore(), isNull);
      verifyNever(() => api.me());
    });

    test('tokens → GET /users/me mapped', () async {
      await tokens.write(tokenPair);
      when(
        () => api.me(),
      ).thenAnswer((_) async => UserProfileDto.fromJson(userProfileJson()));

      expect(await repository.restore(), distributorUser);
    });

    test(
      '/users/me fails → null, tokens kept (interceptor owns clearing)',
      () async {
        await tokens.write(tokenPair);
        when(() => api.me()).thenThrow(
          const ApiException(code: ApiException.networkError, message: 'x'),
        );

        expect(await repository.restore(), isNull);
        expect(await tokens.read(), isNotNull);
      },
    );
  });

  test('saveTokens persists the pair', () async {
    await repository.saveTokens(tokenPair);
    expect((await tokens.read())?.accessToken, 'acc-1');
  });

  group('logout', () {
    test('POST /auth/logout with refresh token, then clears', () async {
      await tokens.write(tokenPair);
      when(() => api.logout(any())).thenAnswer((_) async {});

      await repository.logout();

      verify(() => api.logout('ref-1')).called(1);
      expect(await tokens.read(), isNull);
    });

    test('server call fails → still cleared', () async {
      await tokens.write(tokenPair);
      when(() => api.logout(any())).thenThrow(
        const ApiException(code: ApiException.networkError, message: 'x'),
      );

      await repository.logout();

      expect(await tokens.read(), isNull);
    });

    test('no tokens → no server call', () async {
      await repository.logout();
      verifyNever(() => api.logout(any()));
    });
  });
}
