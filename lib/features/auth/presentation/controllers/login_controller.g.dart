// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Submits the login form. Success → tokens saved and [authStateProvider]
/// becomes Authenticated with the returned profile (no extra /users/me);
/// the router guard then leaves /auth/login (postLoginPath). The login
/// handoff is cleared.
///
/// USER_NOT_ACTIVE → saves the activate handoff (loginType, identifier,
/// at = epoch) so the "kích hoạt" link opens /auth/activate prefilled with
/// resend enabled (no code was just sent).

@ProviderFor(LoginController)
final loginControllerProvider = LoginControllerProvider._();

/// Submits the login form. Success → tokens saved and [authStateProvider]
/// becomes Authenticated with the returned profile (no extra /users/me);
/// the router guard then leaves /auth/login (postLoginPath). The login
/// handoff is cleared.
///
/// USER_NOT_ACTIVE → saves the activate handoff (loginType, identifier,
/// at = epoch) so the "kích hoạt" link opens /auth/activate prefilled with
/// resend enabled (no code was just sent).
final class LoginControllerProvider
    extends $AsyncNotifierProvider<LoginController, void> {
  /// Submits the login form. Success → tokens saved and [authStateProvider]
  /// becomes Authenticated with the returned profile (no extra /users/me);
  /// the router guard then leaves /auth/login (postLoginPath). The login
  /// handoff is cleared.
  ///
  /// USER_NOT_ACTIVE → saves the activate handoff (loginType, identifier,
  /// at = epoch) so the "kích hoạt" link opens /auth/activate prefilled with
  /// resend enabled (no code was just sent).
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

String _$loginControllerHash() => r'c329b5dd239e3ea115f51841d76c625193c53747';

/// Submits the login form. Success → tokens saved and [authStateProvider]
/// becomes Authenticated with the returned profile (no extra /users/me);
/// the router guard then leaves /auth/login (postLoginPath). The login
/// handoff is cleared.
///
/// USER_NOT_ACTIVE → saves the activate handoff (loginType, identifier,
/// at = epoch) so the "kích hoạt" link opens /auth/activate prefilled with
/// resend enabled (no code was just sent).

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
