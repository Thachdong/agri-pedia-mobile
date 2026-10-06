import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/utils/clock.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/register_request.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/shared/enums/user_role.dart';

part 'register_controller.g.dart';

/// What the UI does after a successful registration.
enum RegisterOutcome {
  /// DISTRIBUTOR: account PENDING, code sent → /auth/activate.
  needsActivation,

  /// FARMER: account ACTIVE → /auth/login.
  canLogin,
}

/// Submits the register form. State: null until a submit succeeds, then the
/// [RegisterOutcome]. Invalidates nothing: no cached data depends on a new,
/// not-yet-logged-in account.
///
/// DISTRIBUTOR success → saves the activate handoff (loginType, identifier,
/// at = now) so /auth/activate can prefill and run the resend countdown.
@riverpod
class RegisterController extends _$RegisterController {
  @override
  FutureOr<RegisterOutcome?> build() => null;

  /// The outcome on success; null on failure (`state` holds the
  /// `ApiException`).
  Future<RegisterOutcome?> submit(RegisterRequest request) async {
    final buildRef = ref; // `ref` returns the latest Ref after a rebuild
    // Read dependencies before awaiting: the controller may be disposed
    // while the request is in flight.
    final repository = ref.read(authRepositoryProvider);
    final handoffStore = ref.read(authHandoffStoreProvider);
    final now = ref.read(clockProvider);

    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await repository.register(request);
      if (request.role != UserRole.distributor) {
        return RegisterOutcome.canLogin;
      }
      await handoffStore.save(
        AuthHandoff(
          loginType: request.loginType,
          identifier: request.identifier,
          at: now(),
          purpose: OtpPurpose.activateDistributor,
        ),
      );
      return RegisterOutcome.needsActivation;
    });
    if (!buildRef.mounted) return result.value;
    state = result;
    return result.value;
  }
}
