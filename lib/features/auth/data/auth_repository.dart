import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/network/api_client.dart';
import 'package:ui_ux/features/auth/data/auth_api.dart';
import 'package:ui_ux/features/auth/data/dtos/activate_request.dart';
import 'package:ui_ux/features/auth/data/dtos/register_request.dart';

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
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) =>
    AuthRepository(AuthApi(ref.watch(apiClientProvider)));
