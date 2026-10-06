import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/network/session_events.dart';
import 'package:ui_ux/core/storage/token_storage.dart';
import 'package:ui_ux/features/auth/data/auth_session_repository.dart';
import 'package:ui_ux/features/auth/domain/models/auth_state.dart';
import 'package:ui_ux/features/auth/domain/models/current_user.dart';

part 'auth_state_controller.g.dart';

/// App session (CLAUDE.md decisions 3, 8). Starts from the stored tokens
/// (GET /users/me); becomes [Guest] on logout or when the refresh token is
/// rejected (`SessionEvents.expired`).
@Riverpod(keepAlive: true, name: 'authStateProvider')
class AuthStateController extends _$AuthStateController {
  @override
  Future<AuthState> build() async {
    final sub = ref
        .watch(sessionEventsProvider)
        .expired
        .listen((_) => state = const AsyncData(Guest()));
    ref.onDispose(sub.cancel);

    final user = await ref.read(authSessionRepositoryProvider).restore();
    return user == null ? const Guest() : Authenticated(user);
  }

  /// After a successful login: persist [tokens], become [Authenticated].
  Future<void> signedIn(TokenPair tokens, CurrentUser user) async {
    await ref.read(authSessionRepositoryProvider).saveTokens(tokens);
    state = AsyncData(Authenticated(user));
  }

  /// Revokes the session (best effort) and becomes [Guest].
  Future<void> logout() async {
    await ref.read(authSessionRepositoryProvider).logout();
    state = const AsyncData(Guest());
  }
}

/// True when logged in; false for guests and while the session loads.
@riverpod
bool isLoggedIn(Ref ref) => ref.watch(authStateProvider).value is Authenticated;

/// The logged-in user, null for guests and while the session loads.
@riverpod
CurrentUser? currentUser(Ref ref) =>
    switch (ref.watch(authStateProvider).value) {
      Authenticated(:final user) => user,
      _ => null,
    };
