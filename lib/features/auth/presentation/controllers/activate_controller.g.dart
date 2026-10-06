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
/// The login handoff ([loginType] + identifier) is saved so /auth/login
/// can prefill.

@ProviderFor(ActivateController)
final activateControllerProvider = ActivateControllerProvider._();

/// Submits the activate form. Success → the activate handoff is cleared
/// (ui-ux.md §2) and [authHandoffProvider] for it invalidated; the account is
/// ACTIVE, the UI goes to /auth/login.
/// The login handoff ([loginType] + identifier) is saved so /auth/login
/// can prefill.
final class ActivateControllerProvider
    extends $AsyncNotifierProvider<ActivateController, void> {
  /// Submits the activate form. Success → the activate handoff is cleared
  /// (ui-ux.md §2) and [authHandoffProvider] for it invalidated; the account is
  /// ACTIVE, the UI goes to /auth/login.
  /// The login handoff ([loginType] + identifier) is saved so /auth/login
  /// can prefill.
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
    r'93a50a1ecb051f267bf7fd8b920b762663d347f3';

/// Submits the activate form. Success → the activate handoff is cleared
/// (ui-ux.md §2) and [authHandoffProvider] for it invalidated; the account is
/// ACTIVE, the UI goes to /auth/login.
/// The login handoff ([loginType] + identifier) is saved so /auth/login
/// can prefill.

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
