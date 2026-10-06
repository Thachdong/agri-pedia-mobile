// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// App session (CLAUDE.md decisions 3, 8). Starts from the stored tokens
/// (GET /users/me); becomes [Guest] on logout or when the refresh token is
/// rejected (`SessionEvents.expired`).

@ProviderFor(AuthStateController)
final authStateProvider = AuthStateControllerProvider._();

/// App session (CLAUDE.md decisions 3, 8). Starts from the stored tokens
/// (GET /users/me); becomes [Guest] on logout or when the refresh token is
/// rejected (`SessionEvents.expired`).
final class AuthStateControllerProvider
    extends $AsyncNotifierProvider<AuthStateController, AuthState> {
  /// App session (CLAUDE.md decisions 3, 8). Starts from the stored tokens
  /// (GET /users/me); becomes [Guest] on logout or when the refresh token is
  /// rejected (`SessionEvents.expired`).
  AuthStateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStateControllerHash();

  @$internal
  @override
  AuthStateController create() => AuthStateController();
}

String _$authStateControllerHash() =>
    r'8e06674548e872c51f601b18d566b39095ca6cdd';

/// App session (CLAUDE.md decisions 3, 8). Starts from the stored tokens
/// (GET /users/me); becomes [Guest] on logout or when the refresh token is
/// rejected (`SessionEvents.expired`).

abstract class _$AuthStateController extends $AsyncNotifier<AuthState> {
  FutureOr<AuthState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AuthState>, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthState>, AuthState>,
              AsyncValue<AuthState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// True when logged in; false for guests and while the session loads.

@ProviderFor(isLoggedIn)
final isLoggedInProvider = IsLoggedInProvider._();

/// True when logged in; false for guests and while the session loads.

final class IsLoggedInProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// True when logged in; false for guests and while the session loads.
  IsLoggedInProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isLoggedInProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isLoggedInHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isLoggedIn(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isLoggedInHash() => r'91d3e6bc21c74b57054332d1270e21f0dda60f18';

/// The logged-in user, null for guests and while the session loads.

@ProviderFor(currentUser)
final currentUserProvider = CurrentUserProvider._();

/// The logged-in user, null for guests and while the session loads.

final class CurrentUserProvider
    extends $FunctionalProvider<CurrentUser?, CurrentUser?, CurrentUser?>
    with $Provider<CurrentUser?> {
  /// The logged-in user, null for guests and while the session loads.
  CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $ProviderElement<CurrentUser?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CurrentUser? create(Ref ref) {
    return currentUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrentUser? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrentUser?>(value),
    );
  }
}

String _$currentUserHash() => r'54d6fc9c6f253476bb5110ba3ce4bd4fecddda38';
