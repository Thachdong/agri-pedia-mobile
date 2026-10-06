import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/core/network/api_client.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/auth_api.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/activate_request.dart';
import 'package:ui_ux/features/auth/data/dtos/confirm_password_reset_request.dart';
import 'package:ui_ux/features/auth/data/dtos/request_password_reset_request.dart';
import 'package:ui_ux/features/auth/data/dtos/resend_code_request.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

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

  group('requestPasswordReset', () {
    const request = RequestPasswordResetRequest(
      loginType: LoginType.phone,
      identifier: '0901234567',
    );

    void stubThrow(ApiException e) => when(
      () => client.post<void>('/auth/reset-password', body: any(named: 'body')),
    ).thenThrow(e);

    test('POST /auth/reset-password {loginType, identifier} → null', () async {
      when(
        () =>
            client.post<void>('/auth/reset-password', body: any(named: 'body')),
      ).thenAnswer((_) async {});

      expect(await repository.requestPasswordReset(request), isNull);

      expect(
        verify(
          () => client.post<void>(
            '/auth/reset-password',
            body: captureAny(named: 'body'),
          ),
        ).captured.single,
        {'loginType': 'PHONE', 'identifier': '0901234567'},
      );
    });

    test('409 OTP_ALREADY_REQUESTED → details.issuedAt', () async {
      stubThrow(
        const ApiException(
          statusCode: 409,
          code: 'OTP_ALREADY_REQUESTED',
          message: 'requested',
          details: {
            'purpose': 'RESET_PASSWORD',
            'issuedAt': '2026-10-06T02:00:00.000Z',
            'expiredAt': '2026-10-06T02:05:00.000Z',
          },
        ),
      );

      expect(
        await repository.requestPasswordReset(request),
        DateTime.utc(2026, 10, 6, 2),
      );
    });

    test('409 without readable issuedAt → null', () async {
      stubThrow(
        const ApiException(
          statusCode: 409,
          code: 'OTP_ALREADY_REQUESTED',
          message: 'requested',
        ),
      );

      expect(await repository.requestPasswordReset(request), isNull);
    });

    test('other ApiException propagates', () async {
      stubThrow(
        const ApiException(
          statusCode: 403,
          code: 'OTP_ACCOUNT_NOT_ACTIVE',
          message: 'pending',
        ),
      );

      expect(
        () => repository.requestPasswordReset(request),
        throwsA(
          isA<ApiException>().having(
            (e) => e.code,
            'code',
            'OTP_ACCOUNT_NOT_ACTIVE',
          ),
        ),
      );
    });
  });

  test('confirmPasswordReset: POST /auth/reset-password/confirm '
      '{identifier, code, newPassword}', () async {
    when(
      () => client.post<void>(
        '/auth/reset-password/confirm',
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async {});

    await repository.confirmPasswordReset(
      const ConfirmPasswordResetRequest(
        identifier: 'farmer@example.com',
        code: '123456',
        newPassword: 'new secret',
      ),
    );

    expect(
      verify(
        () => client.post<void>(
          '/auth/reset-password/confirm',
          body: captureAny(named: 'body'),
        ),
      ).captured.single,
      {
        'identifier': 'farmer@example.com',
        'code': '123456',
        'newPassword': 'new secret',
      },
    );
  });
}
