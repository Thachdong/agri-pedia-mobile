// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geolocation_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(geolocationService)
final geolocationServiceProvider = GeolocationServiceProvider._();

final class GeolocationServiceProvider
    extends
        $FunctionalProvider<
          GeolocationService,
          GeolocationService,
          GeolocationService
        >
    with $Provider<GeolocationService> {
  GeolocationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'geolocationServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$geolocationServiceHash();

  @$internal
  @override
  $ProviderElement<GeolocationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GeolocationService create(Ref ref) {
    return geolocationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeolocationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeolocationService>(value),
    );
  }
}

String _$geolocationServiceHash() =>
    r'750bb444a46a3c1f1be6817af9ef4b828cf77225';
