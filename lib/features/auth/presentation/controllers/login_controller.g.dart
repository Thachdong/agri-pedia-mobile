// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Submits the login form. Success → tokens saved and [authStateProvider]
/// becomes Authenticated with the returned profile (no extra /users/me);
/// the router guard then leaves /auth/login (postLoginPath).

@ProviderFor(LoginController)
final loginControllerProvider = LoginControllerProvider._();

/// Submits the login form. Success → tokens saved and [authStateProvider]
/// becomes Authenticated with the returned profile (no extra /users/me);
/// the router guard then leaves /auth/login (postLoginPath).
final class LoginControllerProvider
    extends $AsyncNotifierProvider<LoginController, void> {
  /// Submits the login form. Success → tokens saved and [authStateProvider]
  /// becomes Authenticated with the returned profile (no extra /users/me);
  /// the router guard then leaves /auth/login (postLoginPath).
  LoginControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginControllerHash();

  @$internal
  @override
  LoginController create() => LoginController();
}

String _$loginControllerHash() => r'7c61acc1b21f22ec488b1c7ebae4fdb52ae29923';

/// Submits the login form. Success → tokens saved and [authStateProvider]
/// becomes Authenticated with the returned profile (no extra /users/me);
/// the router guard then leaves /auth/login (postLoginPath).

abstract class _$LoginController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
