// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Submits the register form. Invalidates nothing: no cached data depends on
/// a new, not-yet-logged-in account.
///
/// DISTRIBUTOR success → saves the activate handoff (loginType, identifier,
/// at = now) so /auth/activate can prefill and run the resend countdown.

@ProviderFor(RegisterController)
final registerControllerProvider = RegisterControllerProvider._();

/// Submits the register form. Invalidates nothing: no cached data depends on
/// a new, not-yet-logged-in account.
///
/// DISTRIBUTOR success → saves the activate handoff (loginType, identifier,
/// at = now) so /auth/activate can prefill and run the resend countdown.
final class RegisterControllerProvider
    extends $AsyncNotifierProvider<RegisterController, void> {
  /// Submits the register form. Invalidates nothing: no cached data depends on
  /// a new, not-yet-logged-in account.
  ///
  /// DISTRIBUTOR success → saves the activate handoff (loginType, identifier,
  /// at = now) so /auth/activate can prefill and run the resend countdown.
  RegisterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerControllerHash();

  @$internal
  @override
  RegisterController create() => RegisterController();
}

String _$registerControllerHash() =>
    r'24c70b75709774896257f31b82923e0eda0489c7';

/// Submits the register form. Invalidates nothing: no cached data depends on
/// a new, not-yet-logged-in account.
///
/// DISTRIBUTOR success → saves the activate handoff (loginType, identifier,
/// at = now) so /auth/activate can prefill and run the resend countdown.

abstract class _$RegisterController extends $AsyncNotifier<void> {
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
