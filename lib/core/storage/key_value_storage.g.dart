// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_value_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(keyValueStorage)
final keyValueStorageProvider = KeyValueStorageProvider._();

final class KeyValueStorageProvider
    extends
        $FunctionalProvider<KeyValueStorage, KeyValueStorage, KeyValueStorage>
    with $Provider<KeyValueStorage> {
  KeyValueStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'keyValueStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$keyValueStorageHash();

  @$internal
  @override
  $ProviderElement<KeyValueStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  KeyValueStorage create(Ref ref) {
    return keyValueStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KeyValueStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KeyValueStorage>(value),
    );
  }
}

String _$keyValueStorageHash() => r'8656a1bb1391137fb4b2c8abbeb074116eda9870';
