import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

part 'login_request.freezed.dart';
part 'login_request.g.dart';

/// Body of POST /auth/login (`LoginUserDto`).
@freezed
abstract class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required LoginType loginType,
    required String identifier,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}
