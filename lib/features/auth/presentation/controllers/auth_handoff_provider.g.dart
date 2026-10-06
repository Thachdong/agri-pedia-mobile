// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_handoff_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Handoff saved for [purpose] (register → activate, reset-password →
/// change-password); null when absent. Pages read it once on init to
/// prefill the identifier and resume the resend countdown.

@ProviderFor(authHandoff)
final authHandoffProvider = AuthHandoffFamily._();

/// Handoff saved for [purpose] (register → activate, reset-password →
/// change-password); null when absent. Pages read it once on init to
/// prefill the identifier and resume the resend countdown.

final class AuthHandoffProvider
    extends
        $FunctionalProvider<
          AsyncValue<AuthHandoff?>,
          AuthHandoff?,
          FutureOr<AuthHandoff?>
        >
    with $FutureModifier<AuthHandoff?>, $FutureProvider<AuthHandoff?> {
  /// Handoff saved for [purpose] (register → activate, reset-password →
  /// change-password); null when absent. Pages read it once on init to
  /// prefill the identifier and resume the resend countdown.
  AuthHandoffProvider._({
    required AuthHandoffFamily super.from,
    required OtpPurpose super.argument,
  }) : super(
         retry: null,
         name: r'authHandoffProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$authHandoffHash();

  @override
  String toString() {
    return r'authHandoffProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AuthHandoff?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AuthHandoff?> create(Ref ref) {
    final argument = this.argument as OtpPurpose;
    return authHandoff(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthHandoffProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$authHandoffHash() => r'64327e34644e6bf4bd4ef18e7de7fac714dd55e6';

/// Handoff saved for [purpose] (register → activate, reset-password →
/// change-password); null when absent. Pages read it once on init to
/// prefill the identifier and resume the resend countdown.

final class AuthHandoffFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AuthHandoff?>, OtpPurpose> {
  AuthHandoffFamily._()
    : super(
        retry: null,
        name: r'authHandoffProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Handoff saved for [purpose] (register → activate, reset-password →
  /// change-password); null when absent. Pages read it once on init to
  /// prefill the identifier and resume the resend countdown.

  AuthHandoffProvider call(OtpPurpose purpose) =>
      AuthHandoffProvider._(argument: purpose, from: this);

  @override
  String toString() => r'authHandoffProvider';
}

/// Account to prefill on /auth/login; null when absent. Read once on init.

@ProviderFor(loginHandoff)
final loginHandoffProvider = LoginHandoffProvider._();

/// Account to prefill on /auth/login; null when absent. Read once on init.

final class LoginHandoffProvider
    extends
        $FunctionalProvider<
          AsyncValue<LoginHandoff?>,
          LoginHandoff?,
          FutureOr<LoginHandoff?>
        >
    with $FutureModifier<LoginHandoff?>, $FutureProvider<LoginHandoff?> {
  /// Account to prefill on /auth/login; null when absent. Read once on init.
  LoginHandoffProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginHandoffProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginHandoffHash();

  @$internal
  @override
  $FutureProviderElement<LoginHandoff?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LoginHandoff?> create(Ref ref) {
    return loginHandoff(ref);
  }
}

String _$loginHandoffHash() => r'de81c5f6c3432e491ab40d81d9b5be02ce61012f';
