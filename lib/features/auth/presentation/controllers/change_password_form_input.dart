import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/dtos/confirm_password_reset_request.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

part 'change_password_form_input.freezed.dart';

/// Change-password form values as typed; [toRequest] applies the submit
/// rules. [loginType] only picks the identifier validator / keyboard and is
/// kept for the resend and login handoffs; it is not sent. Confirm Password
/// is checked client side only and is not part of the input.
@freezed
abstract class ChangePasswordFormInput with _$ChangePasswordFormInput {
  const factory ChangePasswordFormInput({
    required LoginType loginType,
    required String identifier,
    required String password,
    required String code,
  }) = _ChangePasswordFormInput;

  const ChangePasswordFormInput._();

  /// Password is not trimmed: spaces are part of it.
  ConfirmPasswordResetRequest toRequest() => ConfirmPasswordResetRequest(
    identifier: identifier.trim(),
    code: code.trim(),
    newPassword: password,
  );
}

/// Where a change-password / resend server error is shown.
enum ChangePasswordErrorField {
  /// No reset requested for this identifier: under it, with a link to
  /// /auth/reset-password.
  identifier(showResetLink: true),
  code(showResetLink: false),

  /// Code already used: under the form, with a link to /auth/reset-password.
  consumed(showResetLink: true),
  form(showResetLink: false);

  const ChangePasswordErrorField({required this.showResetLink});

  /// Show a link to /auth/reset-password next to the message.
  final bool showResetLink;
}

const _fieldByCode = <String, ChangePasswordErrorField>{
  'OTP_NOT_FOUND': ChangePasswordErrorField.identifier,
  'OTP_INVALID_CODE': ChangePasswordErrorField.code,
  'OTP_EXPIRED': ChangePasswordErrorField.code,
  'OTP_ALREADY_CONSUMED': ChangePasswordErrorField.consumed,
};

/// Field that should display [error]; text comes from `errorMessageOf`
/// (OTP_BLOCKED includes `blockUntil` when the server sends it).
ChangePasswordErrorField changePasswordErrorFieldOf(Object error) =>
    switch (error) {
      ApiException(:final code) =>
        _fieldByCode[code] ?? ChangePasswordErrorField.form,
      _ => ChangePasswordErrorField.form,
    };
