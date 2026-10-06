import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/core/network/api_client.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/auth_api.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';

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
}
