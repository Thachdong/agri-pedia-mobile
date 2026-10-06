import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/dtos/request_password_reset_request.dart';
import 'package:ui_ux/features/auth/presentation/controllers/reset_password_form_input.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

void main() {
  test('toRequest trims identifier, keeps loginType', () {
    const input = ResetPasswordFormInput(
      loginType: LoginType.phone,
      identifier: ' 0901234567  ',
    );
    expect(
      input.toRequest(),
      const RequestPasswordResetRequest(
        loginType: LoginType.phone,
        identifier: '0901234567',
      ),
    );
  });

  test('server error → field', () {
    ApiException e(String code) => ApiException(code: code, message: code);
    expect(
      resetPasswordErrorFieldOf(e('OTP_ACCOUNT_NOT_FOUND')),
      ResetPasswordErrorField.identifier,
    );
    expect(
      resetPasswordErrorFieldOf(e('OTP_ACCOUNT_NOT_ACTIVE')),
      ResetPasswordErrorField.notActivated,
    );
    expect(
      resetPasswordErrorFieldOf(e('OTP_BLOCKED')),
      ResetPasswordErrorField.form,
    );
    expect(
      resetPasswordErrorFieldOf(e(ApiException.validationFailed)),
      ResetPasswordErrorField.form,
    );
    expect(
      resetPasswordErrorFieldOf(e(ApiException.networkError)),
      ResetPasswordErrorField.form,
    );
    expect(
      resetPasswordErrorFieldOf(StateError('x')),
      ResetPasswordErrorField.form,
    );
  });
}
