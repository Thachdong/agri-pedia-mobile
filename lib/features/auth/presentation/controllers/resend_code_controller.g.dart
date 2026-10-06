// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_code_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Resends the [purpose] code (activate, change-password).
///
/// Success → saves the handoff with at = now (so the countdown survives an
/// app restart), invalidates [authHandoffProvider] for [purpose] and
/// restarts `countdownControllerProvider(purpose.value)` for
/// [otpResendCooldown].

@ProviderFor(ResendCodeController)
final resendCodeControllerProvider = ResendCodeControllerFamily._();

/// Resends the [purpose] code (activate, change-password).
///
/// Success → saves the handoff with at = now (so the countdown survives an
/// app restart), invalidates [authHandoffProvider] for [purpose] and
/// restarts `countdownControllerProvider(purpose.value)` for
/// [otpResendCooldown].
final class ResendCodeControllerProvider
    extends $AsyncNotifierProvider<ResendCodeController, void> {
  /// Resends the [purpose] code (activate, change-password).
  ///
  /// Success → saves the handoff with at = now (so the countdown survives an
  /// app restart), invalidates [authHandoffProvider] for [purpose] and
  /// restarts `countdownControllerProvider(purpose.value)` for
  /// [otpResendCooldown].
  ResendCodeControllerProvider._({
    required ResendCodeControllerFamily super.from,
    required OtpPurpose super.argument,
  }) : super(
         retry: null,
         name: r'resendCodeControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$resendCodeControllerHash();

  @override
  String toString() {
    return r'resendCodeControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ResendCodeController create() => ResendCodeController();

  @override
  bool operator ==(Object other) {
    return other is ResendCodeControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$resendCodeControllerHash() =>
    r'833d7d268a6c82dc569104c95744109e25dfacb9';

/// Resends the [purpose] code (activate, change-password).
///
/// Success → saves the handoff with at = now (so the countdown survives an
/// app restart), invalidates [authHandoffProvider] for [purpose] and
/// restarts `countdownControllerProvider(purpose.value)` for
/// [otpResendCooldown].

final class ResendCodeControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ResendCodeController,
          AsyncValue<void>,
          void,
          FutureOr<void>,
          OtpPurpose
        > {
  ResendCodeControllerFamily._()
    : super(
        retry: null,
        name: r'resendCodeControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Resends the [purpose] code (activate, change-password).
  ///
  /// Success → saves the handoff with at = now (so the countdown survives an
  /// app restart), invalidates [authHandoffProvider] for [purpose] and
  /// restarts `countdownControllerProvider(purpose.value)` for
  /// [otpResendCooldown].

  ResendCodeControllerProvider call(OtpPurpose purpose) =>
      ResendCodeControllerProvider._(argument: purpose, from: this);

  @override
  String toString() => r'resendCodeControllerProvider';
}

/// Resends the [purpose] code (activate, change-password).
///
/// Success → saves the handoff with at = now (so the countdown survives an
/// app restart), invalidates [authHandoffProvider] for [purpose] and
/// restarts `countdownControllerProvider(purpose.value)` for
/// [otpResendCooldown].

abstract class _$ResendCodeController extends $AsyncNotifier<void> {
  late final _$args = ref.$arg as OtpPurpose;
  OtpPurpose get purpose => _$args;

  FutureOr<void> build(OtpPurpose purpose);
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
    return element.handleCreate(ref, () => build(_$args));
  }
}
