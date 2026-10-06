import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/dtos/request_password_reset_request.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

part 'reset_password_form_input.freezed.dart';

/// Reset-password form values as typed; [toRequest] applies the submit
/// rules. [loginType] is sent: the server requires it to match the account.
@freezed
abstract class ResetPasswordFormInput with _$ResetPasswordFormInput {
  const factory ResetPasswordFormInput({
    required LoginType loginType,
    required String identifier,
  }) = _ResetPasswordFormInput;

  const ResetPasswordFormInput._();

  RequestPasswordResetRequest toRequest() => RequestPasswordResetRequest(
    loginType: loginType,
    identifier: identifier.trim(),
  );
}

/// Where a reset-password server error is shown.
enum ResetPasswordErrorField {
  identifier,

  /// Under the form, with a link to /auth/activate (account not ACTIVE).
  notActivated,
  form,
}

const _fieldByCode = <String, ResetPasswordErrorField>{
  'OTP_ACCOUNT_NOT_FOUND': ResetPasswordErrorField.identifier,
  'OTP_ACCOUNT_NOT_ACTIVE': ResetPasswordErrorField.notActivated,
};

/// Field that should display [error]; text comes from `errorMessageOf`
/// (OTP_BLOCKED includes `blockUntil` when the server sends it).
/// OTP_ALREADY_REQUESTED never gets here: the repository treats it as
/// success.
ResetPasswordErrorField resetPasswordErrorFieldOf(Object error) =>
    switch (error) {
      ApiException(:final code) =>
        _fieldByCode[code] ?? ResetPasswordErrorField.form,
      _ => ResetPasswordErrorField.form,
    };
