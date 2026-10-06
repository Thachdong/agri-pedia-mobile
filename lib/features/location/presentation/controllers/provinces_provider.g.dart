// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provinces_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// All provinces. Master data: kept alive for the app session so the
/// register / address forms load it once.

@ProviderFor(provinces)
final provincesProvider = ProvincesProvider._();

/// All provinces. Master data: kept alive for the app session so the
/// register / address forms load it once.

final class ProvincesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LocationItemDto>>,
          List<LocationItemDto>,
          FutureOr<List<LocationItemDto>>
        >
    with
        $FutureModifier<List<LocationItemDto>>,
        $FutureProvider<List<LocationItemDto>> {
  /// All provinces. Master data: kept alive for the app session so the
  /// register / address forms load it once.
  ProvincesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'provincesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$provincesHash();

  @$internal
  @override
  $FutureProviderElement<List<LocationItemDto>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LocationItemDto>> create(Ref ref) {
    return provinces(ref);
  }
}

String _$provincesHash() => r'f171d18a67cab1c6bf3096629b65f37523dd8f77';
