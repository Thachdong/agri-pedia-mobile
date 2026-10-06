import 'package:ui_ux/core/network/api_client.dart';
import 'package:ui_ux/features/auth/data/dtos/activate_request.dart';
import 'package:ui_ux/features/auth/data/dtos/confirm_password_reset_request.dart';
import 'package:ui_ux/features/auth/data/dtos/login_request.dart';
import 'package:ui_ux/features/auth/data/dtos/login_response_dto.dart';
import 'package:ui_ux/features/auth/data/dtos/register_request.dart';
import 'package:ui_ux/features/auth/data/dtos/request_password_reset_request.dart';
import 'package:ui_ux/features/auth/data/dtos/resend_code_request.dart';
import 'package:ui_ux/features/auth/data/dtos/user_profile_dto.dart';

class AuthApi {
  AuthApi(this._client);

  final ApiClient _client;

  /// POST /auth/register — 201, empty body.
  Future<void> register(RegisterRequest body) =>
      _client.post<void>('/auth/register', body: body.toJson());

  /// POST /auth/activate — 200, empty body.
  Future<void> activate(ActivateRequest body) =>
      _client.post<void>('/auth/activate', body: body.toJson());

  /// POST /auth/resend — 200, empty body.
  Future<void> resendCode(ResendCodeRequest body) =>
      _client.post<void>('/auth/resend', body: body.toJson());

  /// POST /auth/reset-password — 200, empty body.
  Future<void> requestPasswordReset(RequestPasswordResetRequest body) =>
      _client.post<void>('/auth/reset-password', body: body.toJson());

  /// POST /auth/reset-password/confirm — 200, empty body.
  Future<void> confirmPasswordReset(ConfirmPasswordResetRequest body) =>
      _client.post<void>('/auth/reset-password/confirm', body: body.toJson());

  /// POST /auth/login — 200 tokens + profile.
  Future<LoginResponseDto> login(LoginRequest body) => _client.post(
    '/auth/login',
    body: body.toJson(),
    decode: (json) => LoginResponseDto.fromJson(json! as Map<String, dynamic>),
  );

  /// GET /users/me — profile of the caller (Bearer).
  Future<UserProfileDto> me() => _client.get(
    '/users/me',
    decode: (json) => UserProfileDto.fromJson(json! as Map<String, dynamic>),
  );

  /// POST /auth/logout — 200, empty body; revokes the refresh token family.
  Future<void> logout(String refreshToken) =>
      _client.post<void>('/auth/logout', body: {'refreshToken': refreshToken});
}
