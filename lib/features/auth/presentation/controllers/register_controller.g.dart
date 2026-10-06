// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Submits the register form. Invalidates nothing: no cached data depends on
/// a new, not-yet-logged-in account.

@ProviderFor(RegisterController)
final registerControllerProvider = RegisterControllerProvider._();

/// Submits the register form. Invalidates nothing: no cached data depends on
/// a new, not-yet-logged-in account.
final class RegisterControllerProvider
    extends $AsyncNotifierProvider<RegisterController, void> {
  /// Submits the register form. Invalidates nothing: no cached data depends on
  /// a new, not-yet-logged-in account.
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
    r'01af3390d1b1e54282ce7d51fd80b93959fba214';

/// Submits the register form. Invalidates nothing: no cached data depends on
/// a new, not-yet-logged-in account.

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
