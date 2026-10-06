import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/dtos/confirm_password_reset_request.dart';
import 'package:ui_ux/features/auth/presentation/controllers/change_password_form_input.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

void main() {
  test('toRequest trims identifier and code, keeps password, drops '
      'loginType', () {
    const input = ChangePasswordFormInput(
      loginType: LoginType.phone,
      identifier: ' 0901234567 ',
      password: ' secret 123 ',
      code: ' 123456 ',
    );
    expect(
      input.toRequest(),
      const ConfirmPasswordResetRequest(
        identifier: '0901234567',
        code: '123456',
        newPassword: ' secret 123 ',
      ),
    );
  });

  test('server error → field + reset link', () {
    ChangePasswordErrorField of(Object e) => changePasswordErrorFieldOf(e);
    ApiException e(String code) => ApiException(code: code, message: code);

    expect(of(e('OTP_NOT_FOUND')), ChangePasswordErrorField.identifier);
    expect(of(e('OTP_INVALID_CODE')), ChangePasswordErrorField.code);
    expect(of(e('OTP_EXPIRED')), ChangePasswordErrorField.code);
    expect(of(e('OTP_ALREADY_CONSUMED')), ChangePasswordErrorField.consumed);
    expect(of(e('OTP_BLOCKED')), ChangePasswordErrorField.form);
    expect(of(e(ApiException.networkError)), ChangePasswordErrorField.form);
    expect(of(StateError('x')), ChangePasswordErrorField.form);

    expect(ChangePasswordErrorField.identifier.showResetLink, isTrue);
    expect(ChangePasswordErrorField.consumed.showResetLink, isTrue);
    expect(ChangePasswordErrorField.code.showResetLink, isFalse);
    expect(ChangePasswordErrorField.form.showResetLink, isFalse);
  });
}
