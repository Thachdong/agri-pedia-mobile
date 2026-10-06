import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/login_request.dart';
import 'package:ui_ux/features/auth/presentation/controllers/auth_state_controller.dart';

part 'login_controller.g.dart';

/// Submits the login form. Success → tokens saved and [authStateProvider]
/// becomes Authenticated with the returned profile (no extra /users/me);
/// the router guard then leaves /auth/login (postLoginPath).
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
    final session = ref.read(authStateProvider.notifier);

    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final (:tokens, :user) = await repository.login(request);
      await session.signedIn(tokens, user);
    });
    if (!buildRef.mounted) return !result.hasError;
    state = result;
    return !result.hasError;
  }
}
