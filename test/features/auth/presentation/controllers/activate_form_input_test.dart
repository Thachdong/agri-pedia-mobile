import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/dtos/activate_request.dart';
import 'package:ui_ux/features/auth/presentation/controllers/activate_form_input.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

void main() {
  test('toRequest trims identifier and code, drops loginType', () {
    const input = ActivateFormInput(
      loginType: LoginType.email,
      identifier: '  npp@example.com ',
      code: ' 123456 ',
    );
    expect(
      input.toRequest(),
      const ActivateRequest(identifier: 'npp@example.com', code: '123456'),
    );
  });

  test('server error → field', () {
    ApiException e(String code) => ApiException(code: code, message: code);
    expect(
      activateErrorFieldOf(e('OTP_NOT_FOUND')),
      ActivateErrorField.identifier,
    );
    expect(
      activateErrorFieldOf(e('OTP_INVALID_CODE')),
      ActivateErrorField.code,
    );
    expect(activateErrorFieldOf(e('OTP_EXPIRED')), ActivateErrorField.code);
    expect(
      activateErrorFieldOf(e('OTP_ALREADY_CONSUMED')),
      ActivateErrorField.alreadyActivated,
    );
    expect(activateErrorFieldOf(e('OTP_BLOCKED')), ActivateErrorField.form);
    expect(
      activateErrorFieldOf(e(ApiException.networkError)),
      ActivateErrorField.form,
    );
    expect(activateErrorFieldOf(StateError('x')), ActivateErrorField.form);
  });
}
