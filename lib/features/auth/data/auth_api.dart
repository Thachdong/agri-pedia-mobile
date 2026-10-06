import 'package:ui_ux/core/network/api_client.dart';
import 'package:ui_ux/features/auth/data/dtos/activate_request.dart';
import 'package:ui_ux/features/auth/data/dtos/register_request.dart';
import 'package:ui_ux/features/auth/data/dtos/resend_code_request.dart';

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
}
