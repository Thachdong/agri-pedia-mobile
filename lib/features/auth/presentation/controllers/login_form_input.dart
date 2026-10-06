import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/dtos/login_request.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

part 'login_form_input.freezed.dart';

/// Login form values as typed; [toRequest] applies the submit rules
/// (identifier trimmed, password sent as typed). [loginType] is sent: the
/// server requires it to match the account.
@freezed
abstract class LoginFormInput with _$LoginFormInput {
  const factory LoginFormInput({
    required LoginType loginType,
    required String identifier,
    required String password,
  }) = _LoginFormInput;

  const LoginFormInput._();

  LoginRequest toRequest() => LoginRequest(
    loginType: loginType,
    identifier: identifier.trim(),
    password: password,
  );
}

/// Where a login server error is shown. All under the form (spec): the
/// server doesn't say which of identifier / password is wrong.
enum LoginErrorField {
  /// Under the form, with a link to /auth/activate (DISTRIBUTOR not
  /// activated yet).
  notActivated,
  form,
}

/// Field that should display [error]; text comes from `errorMessageOf`.
LoginErrorField loginErrorFieldOf(Object error) => switch (error) {
  ApiException(code: 'USER_NOT_ACTIVE') => LoginErrorField.notActivated,
  _ => LoginErrorField.form,
};
