import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/utils/clock.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/resend_code_request.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/features/auth/presentation/controllers/auth_handoff_provider.dart';
import 'package:ui_ux/shared/controllers/countdown_controller.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

part 'resend_code_controller.g.dart';

/// Resends the [purpose] code (activate, change-password).
///
/// Success → saves the handoff with at = now (so the countdown survives an
/// app restart), invalidates [authHandoffProvider] for [purpose] and
/// restarts `countdownControllerProvider(purpose.value)` for
/// [otpResendCooldown].
@riverpod
class ResendCodeController extends _$ResendCodeController {
  @override
  FutureOr<void> build(OtpPurpose purpose) {}

  /// True on success; false on failure (`state` holds the `ApiException`).
  Future<bool> resend({
    required LoginType loginType,
    required String identifier,
  }) async {
    final buildRef = ref; // `ref` returns the latest Ref after a rebuild
    // Read dependencies before awaiting: the controller may be disposed
    // while the request is in flight.
    final repository = ref.read(authRepositoryProvider);
    final handoffStore = ref.read(authHandoffStoreProvider);
    final now = ref.read(clockProvider);

    state = const AsyncLoading();
    DateTime? sentAt;
    final result = await AsyncValue.guard(() async {
      await repository.resendCode(
        ResendCodeRequest(identifier: identifier, purpose: purpose),
      );
      final at = sentAt = now();
      await handoffStore.save(
        AuthHandoff(
          loginType: loginType,
          identifier: identifier,
          at: at,
          purpose: purpose,
        ),
      );
    });
    if (!buildRef.mounted) return !result.hasError;
    state = result;
    if (result.hasError) return false;
    ref.invalidate(authHandoffProvider(purpose));
    ref
        .read(countdownControllerProvider(purpose.value).notifier)
        .start(otpResendCooldown, from: sentAt);
    return true;
  }
}
