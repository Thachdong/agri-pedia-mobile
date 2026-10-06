// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Submits the register form. State: null until a submit succeeds, then the
/// [RegisterOutcome]. Invalidates nothing: no cached data depends on a new,
/// not-yet-logged-in account.
///
/// DISTRIBUTOR success → saves the activate handoff (loginType, identifier,
/// at = now) so /auth/activate can prefill and run the resend countdown.
/// FARMER success → saves the login handoff so /auth/login can prefill.

@ProviderFor(RegisterController)
final registerControllerProvider = RegisterControllerProvider._();

/// Submits the register form. State: null until a submit succeeds, then the
/// [RegisterOutcome]. Invalidates nothing: no cached data depends on a new,
/// not-yet-logged-in account.
///
/// DISTRIBUTOR success → saves the activate handoff (loginType, identifier,
/// at = now) so /auth/activate can prefill and run the resend countdown.
/// FARMER success → saves the login handoff so /auth/login can prefill.
final class RegisterControllerProvider
    extends $AsyncNotifierProvider<RegisterController, RegisterOutcome?> {
  /// Submits the register form. State: null until a submit succeeds, then the
  /// [RegisterOutcome]. Invalidates nothing: no cached data depends on a new,
  /// not-yet-logged-in account.
  ///
  /// DISTRIBUTOR success → saves the activate handoff (loginType, identifier,
  /// at = now) so /auth/activate can prefill and run the resend countdown.
  /// FARMER success → saves the login handoff so /auth/login can prefill.
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
    r'804be850002dba6b91670eb0f6ec1d65f75add51';

/// Submits the register form. State: null until a submit succeeds, then the
/// [RegisterOutcome]. Invalidates nothing: no cached data depends on a new,
/// not-yet-logged-in account.
///
/// DISTRIBUTOR success → saves the activate handoff (loginType, identifier,
/// at = now) so /auth/activate can prefill and run the resend countdown.
/// FARMER success → saves the login handoff so /auth/login can prefill.

abstract class _$RegisterController extends $AsyncNotifier<RegisterOutcome?> {
  FutureOr<RegisterOutcome?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<RegisterOutcome?>, RegisterOutcome?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RegisterOutcome?>, RegisterOutcome?>,
              AsyncValue<RegisterOutcome?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
