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

/// Submits the register form. Invalidates nothing: no cached data depends on
/// a new, not-yet-logged-in account.
///
/// DISTRIBUTOR success → saves the activate handoff (loginType, identifier,
/// at = now) so /auth/activate can prefill and run the resend countdown.
@riverpod
class RegisterController extends _$RegisterController {
  @override
  FutureOr<void> build() {}

  /// True on success; on failure `state` holds the `ApiException`.
  Future<bool> submit(RegisterRequest request) async {
    final buildRef = ref; // `ref` returns the latest Ref after a rebuild
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).register(request);
      if (request.role == UserRole.distributor) {
        await ref
            .read(authHandoffStoreProvider)
            .save(
              AuthHandoff(
                loginType: request.loginType,
                identifier: request.identifier,
                at: ref.read(clockProvider)(),
                purpose: OtpPurpose.activateDistributor,
              ),
            );
      }
    });
    if (!buildRef.mounted) return false;
    state = result;
    return !state.hasError;
  }
}
