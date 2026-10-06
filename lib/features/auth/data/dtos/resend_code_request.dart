import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';

part 'resend_code_request.freezed.dart';
part 'resend_code_request.g.dart';

/// Body of POST /auth/resend (`ResendCodeDto`).
@freezed
abstract class ResendCodeRequest with _$ResendCodeRequest {
  const factory ResendCodeRequest({
    required String identifier,
    required OtpPurpose purpose,
  }) = _ResendCodeRequest;

  factory ResendCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendCodeRequestFromJson(json);
}
