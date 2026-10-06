// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_password_reset_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Submits the reset-password form (ui-ux.md §4).
///
/// Success (code sent, or a previous code still valid) → saves the
/// RESET_PASSWORD handoff (loginType, identifier, at = when the code was
/// sent) and invalidates [authHandoffProvider] for it; the UI goes to
/// /auth/change-password.

@ProviderFor(RequestPasswordResetController)
final requestPasswordResetControllerProvider =
    RequestPasswordResetControllerProvider._();

/// Submits the reset-password form (ui-ux.md §4).
///
/// Success (code sent, or a previous code still valid) → saves the
/// RESET_PASSWORD handoff (loginType, identifier, at = when the code was
/// sent) and invalidates [authHandoffProvider] for it; the UI goes to
/// /auth/change-password.
final class RequestPasswordResetControllerProvider
    extends $AsyncNotifierProvider<RequestPasswordResetController, void> {
  /// Submits the reset-password form (ui-ux.md §4).
  ///
  /// Success (code sent, or a previous code still valid) → saves the
  /// RESET_PASSWORD handoff (loginType, identifier, at = when the code was
  /// sent) and invalidates [authHandoffProvider] for it; the UI goes to
  /// /auth/change-password.
  RequestPasswordResetControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestPasswordResetControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestPasswordResetControllerHash();

  @$internal
  @override
  RequestPasswordResetController create() => RequestPasswordResetController();
}

String _$requestPasswordResetControllerHash() =>
    r'0085efcd3dc5b928124533c5f31c77c1543b0799';

/// Submits the reset-password form (ui-ux.md §4).
///
/// Success (code sent, or a previous code still valid) → saves the
/// RESET_PASSWORD handoff (loginType, identifier, at = when the code was
/// sent) and invalidates [authHandoffProvider] for it; the UI goes to
/// /auth/change-password.

abstract class _$RequestPasswordResetController extends $AsyncNotifier<void> {
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
