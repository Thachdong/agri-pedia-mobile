import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/features/location/data/dtos/location_item_dto.dart';
import 'package:ui_ux/features/location/data/location_repository.dart';

part 'wards_provider.g.dart';

/// Wards of the province with `provinceCode` (a province `codename`).
/// Auto-dispose: a new province selection loads its own list.
@riverpod
Future<List<LocationItemDto>> wards(Ref ref, String provinceCode) =>
    ref.watch(locationRepositoryProvider).wards(provinceCode);
