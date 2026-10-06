import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/core/network/api_client.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/auth_api.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/activate_request.dart';
import 'package:ui_ux/features/auth/data/dtos/resend_code_request.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';

import '../../../fixtures/auth_fixtures.dart';

class _MockApiClient extends Mock implements ApiClient {}

void main() {
  late _MockApiClient client;
  late AuthRepository repository;

  setUp(() {
    client = _MockApiClient();
    repository = AuthRepository(AuthApi(client));
  });

  Map<String, Object?> sentBody() =>
      verify(
            () => client.post<void>(
              '/auth/register',
              body: captureAny(named: 'body'),
            ),
          ).captured.single
          as Map<String, Object?>;

  void stubPost() => when(
    () => client.post<void>('/auth/register', body: any(named: 'body')),
  ).thenAnswer((_) async {});

  test('FARMER: POST /auth/register with spec field names', () async {
    stubPost();

    await repository.register(farmerRequest);

    final body = sentBody();
    expect(body, {
      'loginType': 'EMAIL',
      'identifier': 'farmer@example.com',
      'password': 'secret123',
      'role': 'FARMER',
      'bussinessType': null,
      'address': {
        'province': 'ha_noi',
        'ward': 'phuong_ba_dinh',
        'houseNumber': '12 Nguyễn Trãi',
        'lat': 21.03,
        'long': 105.84,
      },
    });
    // Optional fields left out when null; isPrimary never sent.
    expect(body.containsKey('username'), isFalse);
    expect(body.containsKey('bio'), isFalse);
  });

  test('DISTRIBUTOR: bussinessType + optional fields sent', () async {
    stubPost();

    await repository.register(
      distributorRequest.copyWith(username: 'NPP A', bio: 'Giống lúa'),
    );

    final body = sentBody();
    expect(body['loginType'], 'PHONE');
    expect(body['role'], 'DISTRIBUTOR');
    expect(body['bussinessType'], 'SEEDS_SEEDLINGS');
    expect(body['username'], 'NPP A');
    expect(body['bio'], 'Giống lúa');
  });

  test('ApiException propagates', () async {
    when(
      () => client.post<void>('/auth/register', body: any(named: 'body')),
    ).thenThrow(
      const ApiException(
        statusCode: 409,
        code: 'USER_IDENTIFIER_ALREADY_USED',
        message: 'used',
      ),
    );

    expect(
      () => repository.register(farmerRequest),
      throwsA(
        isA<ApiException>().having(
          (e) => e.code,
          'code',
          'USER_IDENTIFIER_ALREADY_USED',
        ),
      ),
    );
  });

  group('activate / resendCode', () {
    Object? bodySentTo(String path) => verify(
      () => client.post<void>(path, body: captureAny(named: 'body')),
    ).captured.single;

    test('activate: POST /auth/activate {identifier, code}', () async {
      when(
        () => client.post<void>('/auth/activate', body: any(named: 'body')),
      ).thenAnswer((_) async {});

      await repository.activate(
        const ActivateRequest(identifier: 'npp@example.com', code: '123456'),
      );

      expect(bodySentTo('/auth/activate'), {
        'identifier': 'npp@example.com',
        'code': '123456',
      });
    });

    test('resendCode: POST /auth/resend with server purpose value', () async {
      when(
        () => client.post<void>('/auth/resend', body: any(named: 'body')),
      ).thenAnswer((_) async {});

      await repository.resendCode(
        const ResendCodeRequest(
          identifier: '0901234567',
          purpose: OtpPurpose.activateDistributor,
        ),
      );

      expect(bodySentTo('/auth/resend'), {
        'identifier': '0901234567',
        'purpose': 'ACTIVATE_DISTRIBUTOR',
      });
    });
  });
}
