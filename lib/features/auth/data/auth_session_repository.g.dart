// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authSessionRepository)
final authSessionRepositoryProvider = AuthSessionRepositoryProvider._();

final class AuthSessionRepositoryProvider
    extends
        $FunctionalProvider<
          AuthSessionRepository,
          AuthSessionRepository,
          AuthSessionRepository
        >
    with $Provider<AuthSessionRepository> {
  AuthSessionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSessionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSessionRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthSessionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthSessionRepository create(Ref ref) {
    return authSessionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthSessionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthSessionRepository>(value),
    );
  }
}

String _$authSessionRepositoryHash() =>
    r'5dd158f7a13883c04a7e01ffc4dfa8833e34610d';
