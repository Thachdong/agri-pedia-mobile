import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/network/api_client.dart';
import 'package:ui_ux/features/location/data/dtos/location_item_dto.dart';
import 'package:ui_ux/features/location/data/location_api.dart';

part 'location_repository.g.dart';

/// Province / ward master data. Returns DTOs (no domain layer needed).
class LocationRepository {
  LocationRepository(this._api);

  final LocationApi _api;

  Future<List<LocationItemDto>> provinces() => _api.provinces();
}

@Riverpod(keepAlive: true)
LocationRepository locationRepository(Ref ref) =>
    LocationRepository(LocationApi(ref.watch(apiClientProvider)));
