import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_password_reset_request.freezed.dart';
part 'confirm_password_reset_request.g.dart';

/// Body of POST /auth/reset-password/confirm (`ConfirmPasswordResetDto`).
/// [identifier] is the email or phone the code was sent to; [code] matches
/// `^\d{4,10}$`; [newPassword] is 8..128 chars.
@freezed
abstract class ConfirmPasswordResetRequest with _$ConfirmPasswordResetRequest {
  const factory ConfirmPasswordResetRequest({
    required String identifier,
    required String code,
    required String newPassword,
  }) = _ConfirmPasswordResetRequest;

  factory ConfirmPasswordResetRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPasswordResetRequestFromJson(json);
}
