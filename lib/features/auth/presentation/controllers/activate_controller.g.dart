// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activate_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Submits the activate form. Success → the activate handoff is cleared
/// (ui-ux.md §2) and [authHandoffProvider] for it invalidated; the account is
/// ACTIVE, the UI goes to /auth/login.

@ProviderFor(ActivateController)
final activateControllerProvider = ActivateControllerProvider._();

/// Submits the activate form. Success → the activate handoff is cleared
/// (ui-ux.md §2) and [authHandoffProvider] for it invalidated; the account is
/// ACTIVE, the UI goes to /auth/login.
final class ActivateControllerProvider
    extends $AsyncNotifierProvider<ActivateController, void> {
  /// Submits the activate form. Success → the activate handoff is cleared
  /// (ui-ux.md §2) and [authHandoffProvider] for it invalidated; the account is
  /// ACTIVE, the UI goes to /auth/login.
  ActivateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activateControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activateControllerHash();

  @$internal
  @override
  ActivateController create() => ActivateController();
}

String _$activateControllerHash() =>
    r'6a524793ac0b553f90ad0b4aac448c25f49cf8d4';

/// Submits the activate form. Success → the activate handoff is cleared
/// (ui-ux.md §2) and [authHandoffProvider] for it invalidated; the account is
/// ACTIVE, the UI goes to /auth/login.

abstract class _$ActivateController extends $AsyncNotifier<void> {
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
