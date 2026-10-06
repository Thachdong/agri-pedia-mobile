import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

part 'request_password_reset_request.freezed.dart';
part 'request_password_reset_request.g.dart';

/// Body of POST /auth/reset-password (`RequestPasswordResetDto`).
@freezed
abstract class RequestPasswordResetRequest with _$RequestPasswordResetRequest {
  const factory RequestPasswordResetRequest({
    required LoginType loginType,
    required String identifier,
  }) = _RequestPasswordResetRequest;

  factory RequestPasswordResetRequest.fromJson(Map<String, dynamic> json) =>
      _$RequestPasswordResetRequestFromJson(json);
}
