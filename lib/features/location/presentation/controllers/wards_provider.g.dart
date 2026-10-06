// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wards_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Wards of the province with `provinceCode` (a province `codename`).
/// Auto-dispose: a new province selection loads its own list.

@ProviderFor(wards)
final wardsProvider = WardsFamily._();

/// Wards of the province with `provinceCode` (a province `codename`).
/// Auto-dispose: a new province selection loads its own list.

final class WardsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LocationItemDto>>,
          List<LocationItemDto>,
          FutureOr<List<LocationItemDto>>
        >
    with
        $FutureModifier<List<LocationItemDto>>,
        $FutureProvider<List<LocationItemDto>> {
  /// Wards of the province with `provinceCode` (a province `codename`).
  /// Auto-dispose: a new province selection loads its own list.
  WardsProvider._({
    required WardsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'wardsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$wardsHash();

  @override
  String toString() {
    return r'wardsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<LocationItemDto>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LocationItemDto>> create(Ref ref) {
    final argument = this.argument as String;
    return wards(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WardsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$wardsHash() => r'802546066827111fe1d6e21a0227fce983fb0d7e';

/// Wards of the province with `provinceCode` (a province `codename`).
/// Auto-dispose: a new province selection loads its own list.

final class WardsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<LocationItemDto>>, String> {
  WardsFamily._()
    : super(
        retry: null,
        name: r'wardsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Wards of the province with `provinceCode` (a province `codename`).
  /// Auto-dispose: a new province selection loads its own list.

  WardsProvider call(String provinceCode) =>
      WardsProvider._(argument: provinceCode, from: this);

  @override
  String toString() => r'wardsProvider';
}
