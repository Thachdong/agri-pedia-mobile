import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/network/api_client.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/auth_api.dart';
import 'package:ui_ux/features/auth/data/dtos/activate_request.dart';
import 'package:ui_ux/features/auth/data/dtos/register_request.dart';
import 'package:ui_ux/features/auth/data/dtos/request_password_reset_request.dart';
import 'package:ui_ux/features/auth/data/dtos/resend_code_request.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._api);

  final AuthApi _api;

  /// FARMER is ACTIVE right away; DISTRIBUTOR is PENDING and receives an
  /// activation code (ACTIVATE_DISTRIBUTOR) on its identifier.
  Future<void> register(RegisterRequest request) => _api.register(request);

  /// Activates a PENDING DISTRIBUTOR with its ACTIVATE_DISTRIBUTOR code.
  /// Wrong codes are counted server side (too many → OTP_BLOCKED).
  Future<void> activate(ActivateRequest request) => _api.activate(request);

  /// Sends the latest code of `purpose` again while valid, or issues a new
  /// one if it expired. Resends are counted (too many → OTP_BLOCKED with
  /// `details.blockUntil`).
  Future<void> resendCode(ResendCodeRequest request) =>
      _api.resendCode(request);

  /// Sends a RESET_PASSWORD code to an ACTIVE account.
  ///
  /// Returns null when a new code was sent now. While the previous code is
  /// still valid the server answers 409 OTP_ALREADY_REQUESTED: that is not a
  /// failure for the flow (the user enters that code), so its
  /// `details.issuedAt` is returned instead (null if unreadable).
  Future<DateTime?> requestPasswordReset(
    RequestPasswordResetRequest request,
  ) async {
    try {
      await _api.requestPasswordReset(request);
      return null;
    } on ApiException catch (e) {
      if (e.code != 'OTP_ALREADY_REQUESTED') rethrow;
      final issuedAt = e.details?['issuedAt'];
      return issuedAt is String ? DateTime.tryParse(issuedAt) : null;
    }
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) =>
    AuthRepository(AuthApi(ref.watch(apiClientProvider)));
