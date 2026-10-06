import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/dtos/activate_request.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

part 'activate_form_input.freezed.dart';

/// Activate form values as typed; [toRequest] applies the submit rules.
/// [loginType] only picks the identifier validator / keyboard and is kept
/// for the resend and login handoffs; the server accepts any identifier
/// format.
@freezed
abstract class ActivateFormInput with _$ActivateFormInput {
  const factory ActivateFormInput({
    required LoginType loginType,
    required String identifier,
    required String code,
  }) = _ActivateFormInput;

  const ActivateFormInput._();

  ActivateRequest toRequest() =>
      ActivateRequest(identifier: identifier.trim(), code: code.trim());
}

/// Where an activate / resend server error is shown.
enum ActivateErrorField {
  identifier,
  code,

  /// Under the form, with a link to /auth/login (account already ACTIVE).
  alreadyActivated,
  form,
}

const _fieldByCode = <String, ActivateErrorField>{
  'OTP_NOT_FOUND': ActivateErrorField.identifier,
  'OTP_INVALID_CODE': ActivateErrorField.code,
  'OTP_EXPIRED': ActivateErrorField.code,
  'OTP_ALREADY_CONSUMED': ActivateErrorField.alreadyActivated,
};

/// Field that should display [error]; text comes from `errorMessageOf`
/// (OTP_BLOCKED includes `blockUntil` when the server sends it).
ActivateErrorField activateErrorFieldOf(Object error) => switch (error) {
  ApiException(:final code) => _fieldByCode[code] ?? ActivateErrorField.form,
  _ => ActivateErrorField.form,
};
