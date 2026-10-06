// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_handoff_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authHandoffStore)
final authHandoffStoreProvider = AuthHandoffStoreProvider._();

final class AuthHandoffStoreProvider
    extends
        $FunctionalProvider<
          AuthHandoffStore,
          AuthHandoffStore,
          AuthHandoffStore
        >
    with $Provider<AuthHandoffStore> {
  AuthHandoffStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authHandoffStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHandoffStoreHash();

  @$internal
  @override
  $ProviderElement<AuthHandoffStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthHandoffStore create(Ref ref) {
    return authHandoffStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthHandoffStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthHandoffStore>(value),
    );
  }
}

String _$authHandoffStoreHash() => r'368d802474138f168293867dc0876b8da87f6a0b';
