import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/utils/clock.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/request_password_reset_request.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/features/auth/presentation/controllers/auth_handoff_provider.dart';

part 'request_password_reset_controller.g.dart';

/// Submits the reset-password form (ui-ux.md §4).
///
/// Success (code sent, or a previous code still valid) → saves the
/// RESET_PASSWORD handoff (loginType, identifier, at = when the code was
/// sent) and invalidates [authHandoffProvider] for it; the UI goes to
/// /auth/change-password.
@riverpod
class RequestPasswordResetController extends _$RequestPasswordResetController {
  @override
  FutureOr<void> build() {}

  /// True on success; false on failure (`state` holds the `ApiException`).
  Future<bool> submit(RequestPasswordResetRequest request) async {
    final buildRef = ref; // `ref` returns the latest Ref after a rebuild
    // Read dependencies before awaiting: the controller may be disposed
    // while the request is in flight.
    final repository = ref.read(authRepositoryProvider);
    final handoffStore = ref.read(authHandoffStoreProvider);
    final now = ref.read(clockProvider);

    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final issuedAt = await repository.requestPasswordReset(request);
      await handoffStore.save(
        AuthHandoff(
          loginType: request.loginType,
          identifier: request.identifier,
          at: issuedAt ?? now(),
          purpose: OtpPurpose.resetPassword,
        ),
      );
    });
    if (!buildRef.mounted) return !result.hasError;
    state = result;
    if (result.hasError) return false;
    ref.invalidate(authHandoffProvider(OtpPurpose.resetPassword));
    return true;
  }
}
