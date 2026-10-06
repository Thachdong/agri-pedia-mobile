import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/dtos/login_request.dart';
import 'package:ui_ux/features/auth/presentation/controllers/login_form_input.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

void main() {
  test('toRequest trims identifier, keeps password as typed', () {
    const input = LoginFormInput(
      loginType: LoginType.phone,
      identifier: ' 0901234567 ',
      password: ' p@ss word ',
    );

    expect(
      input.toRequest(),
      const LoginRequest(
        loginType: LoginType.phone,
        identifier: '0901234567',
        password: ' p@ss word ',
      ),
    );
    expect(input.toRequest().toJson(), {
      'loginType': 'PHONE',
      'identifier': '0901234567',
      'password': ' p@ss word ',
    });
  });

  group('loginErrorFieldOf', () {
    ApiException error(String code, int status) =>
        ApiException(code: code, message: code, statusCode: status);

    test('USER_NOT_ACTIVE → notActivated (activate link)', () {
      expect(
        loginErrorFieldOf(error('USER_NOT_ACTIVE', 403)),
        LoginErrorField.notActivated,
      );
    });

    test('credentials / validation / network / other → form', () {
      expect(
        loginErrorFieldOf(error('USER_INVALID_CREDENTIALS', 401)),
        LoginErrorField.form,
      );
      expect(
        loginErrorFieldOf(error(ApiException.validationFailed, 400)),
        LoginErrorField.form,
      );
      expect(
        loginErrorFieldOf(error(ApiException.networkError, 0)),
        LoginErrorField.form,
      );
      expect(loginErrorFieldOf(StateError('x')), LoginErrorField.form);
    });
  });
}
