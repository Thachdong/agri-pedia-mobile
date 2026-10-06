import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/login_request.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/features/auth/presentation/controllers/auth_handoff_provider.dart';
import 'package:ui_ux/features/auth/presentation/controllers/auth_state_controller.dart';
import 'package:ui_ux/features/auth/presentation/controllers/login_form_input.dart';

part 'login_controller.g.dart';

/// Submits the login form. Success → tokens saved and [authStateProvider]
/// becomes Authenticated with the returned profile (no extra /users/me);
/// the router guard then leaves /auth/login (postLoginPath). The login
/// handoff is cleared.
///
/// USER_NOT_ACTIVE → saves the activate handoff (loginType, identifier,
/// at = epoch) so the "kích hoạt" link opens /auth/activate prefilled with
/// resend enabled (no code was just sent).
@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {}

  /// True on success; false on failure (`state` holds the `ApiException`).
  Future<bool> submit(LoginRequest request) async {
    final buildRef = ref; // `ref` returns the latest Ref after a rebuild
    // Read dependencies before awaiting: the controller may be disposed
    // when the redirect removes the login page.
    final repository = ref.read(authRepositoryProvider);
    final handoffStore = ref.read(authHandoffStoreProvider);
    final session = ref.read(authStateProvider.notifier);

    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      try {
        final (:tokens, :user) = await repository.login(request);
        await handoffStore.clearLogin();
        await session.signedIn(tokens, user);
      } on ApiException catch (e) {
        if (loginErrorFieldOf(e) == LoginErrorField.notActivated) {
          await handoffStore.save(
            AuthHandoff(
              loginType: request.loginType,
              identifier: request.identifier,
              at: DateTime.fromMillisecondsSinceEpoch(0),
              purpose: OtpPurpose.activateDistributor,
            ),
          );
        }
        rethrow;
      }
    });
    if (!buildRef.mounted) return !result.hasError;
    state = result;
    if (result.error case final error?
        when loginErrorFieldOf(error) == LoginErrorField.notActivated) {
      ref.invalidate(authHandoffProvider(OtpPurpose.activateDistributor));
    }
    if (result.hasError) return false;
    ref.invalidate(loginHandoffProvider);
    return true;
  }
}
