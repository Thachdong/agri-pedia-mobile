import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/activate_request.dart';
import 'package:ui_ux/features/auth/domain/models/login_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/features/auth/presentation/controllers/auth_handoff_provider.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

part 'activate_controller.g.dart';

/// Submits the activate form. Success → the activate handoff is cleared
/// (ui-ux.md §2) and [authHandoffProvider] for it invalidated; the account is
/// ACTIVE, the UI goes to /auth/login.
/// The login handoff ([loginType] + identifier) is saved so /auth/login
/// can prefill.
@riverpod
class ActivateController extends _$ActivateController {
  @override
  FutureOr<void> build() {}

  /// True on success; false on failure (`state` holds the `ApiException`).
  Future<bool> submit(
    ActivateRequest request, {
    required LoginType loginType,
  }) async {
    final buildRef = ref; // `ref` returns the latest Ref after a rebuild
    // Read dependencies before awaiting: the controller may be disposed
    // while the request is in flight.
    final repository = ref.read(authRepositoryProvider);
    final handoffStore = ref.read(authHandoffStoreProvider);

    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await repository.activate(request);
      await handoffStore.clear(OtpPurpose.activateDistributor);
      await handoffStore.saveLogin(
        LoginHandoff(loginType: loginType, identifier: request.identifier),
      );
    });
    if (!buildRef.mounted) return !result.hasError;
    state = result;
    if (result.hasError) return false;
    ref.invalidate(loginHandoffProvider);
    ref.invalidate(authHandoffProvider(OtpPurpose.activateDistributor));
    return true;
  }
}
