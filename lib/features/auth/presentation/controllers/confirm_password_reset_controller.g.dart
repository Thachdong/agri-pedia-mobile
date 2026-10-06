// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_password_reset_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Submits the change-password form (ui-ux.md §5). Success → the
/// RESET_PASSWORD handoff is cleared and [authHandoffProvider] for it
/// invalidated; the password is replaced, the UI goes to /auth/login.

@ProviderFor(ConfirmPasswordResetController)
final confirmPasswordResetControllerProvider =
    ConfirmPasswordResetControllerProvider._();

/// Submits the change-password form (ui-ux.md §5). Success → the
/// RESET_PASSWORD handoff is cleared and [authHandoffProvider] for it
/// invalidated; the password is replaced, the UI goes to /auth/login.
final class ConfirmPasswordResetControllerProvider
    extends $AsyncNotifierProvider<ConfirmPasswordResetController, void> {
  /// Submits the change-password form (ui-ux.md §5). Success → the
  /// RESET_PASSWORD handoff is cleared and [authHandoffProvider] for it
  /// invalidated; the password is replaced, the UI goes to /auth/login.
  ConfirmPasswordResetControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'confirmPasswordResetControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$confirmPasswordResetControllerHash();

  @$internal
  @override
  ConfirmPasswordResetController create() => ConfirmPasswordResetController();
}

String _$confirmPasswordResetControllerHash() =>
    r'51799977b6cd44a698e89df866cca1a5a38bc85b';

/// Submits the change-password form (ui-ux.md §5). Success → the
/// RESET_PASSWORD handoff is cleared and [authHandoffProvider] for it
/// invalidated; the password is replaced, the UI goes to /auth/login.

abstract class _$ConfirmPasswordResetController extends $AsyncNotifier<void> {
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
