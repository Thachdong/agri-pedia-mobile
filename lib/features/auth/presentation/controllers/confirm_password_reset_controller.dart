import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/confirm_password_reset_request.dart';
import 'package:ui_ux/features/auth/domain/models/login_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/features/auth/presentation/controllers/auth_handoff_provider.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

part 'confirm_password_reset_controller.g.dart';

/// Submits the change-password form (ui-ux.md §5). Success → the
/// RESET_PASSWORD handoff is cleared and [authHandoffProvider] for it
/// invalidated; the password is replaced, the UI goes to /auth/login.
/// The login handoff ([loginType] + identifier) is saved so /auth/login
/// can prefill.
@riverpod
class ConfirmPasswordResetController extends _$ConfirmPasswordResetController {
  @override
  FutureOr<void> build() {}

  /// True on success; false on failure (`state` holds the `ApiException`).
  Future<bool> submit(
    ConfirmPasswordResetRequest request, {
    required LoginType loginType,
  }) async {
    final buildRef = ref; // `ref` returns the latest Ref after a rebuild
    // Read dependencies before awaiting: the controller may be disposed
    // while the request is in flight.
    final repository = ref.read(authRepositoryProvider);
    final handoffStore = ref.read(authHandoffStoreProvider);

    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await repository.confirmPasswordReset(request);
      await handoffStore.clear(OtpPurpose.resetPassword);
      await handoffStore.saveLogin(
        LoginHandoff(loginType: loginType, identifier: request.identifier),
      );
    });
    if (!buildRef.mounted) return !result.hasError;
    state = result;
    if (result.hasError) return false;
    ref.invalidate(loginHandoffProvider);
    ref.invalidate(authHandoffProvider(OtpPurpose.resetPassword));
    return true;
  }
}
