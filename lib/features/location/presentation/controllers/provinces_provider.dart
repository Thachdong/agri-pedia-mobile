import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/features/location/data/dtos/location_item_dto.dart';
import 'package:ui_ux/features/location/data/location_repository.dart';

part 'provinces_provider.g.dart';

/// All provinces. Master data: kept alive for the app session so the
/// register / address forms load it once.
@Riverpod(keepAlive: true)
Future<List<LocationItemDto>> provinces(Ref ref) =>
    ref.watch(locationRepositoryProvider).provinces();
