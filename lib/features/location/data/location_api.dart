import 'package:ui_ux/core/network/api_client.dart';
import 'package:ui_ux/features/location/data/dtos/location_item_dto.dart';

class LocationApi {
  LocationApi(this._client);

  final ApiClient _client;

  /// GET /provinces — `{ provinces: [...] }`, master data order.
  Future<List<LocationItemDto>> provinces() =>
      _client.get('/provinces', decode: (json) => _items(json, 'provinces'));

  /// GET /provinces/{provinceCode}/wards — `{ wards: [...] }`.
  /// `provinceCode` is a province `codename` (`^[a-z0-9_]{1,64}$`).
  Future<List<LocationItemDto>> wards(String provinceCode) => _client.get(
    '/provinces/${Uri.encodeComponent(provinceCode)}/wards',
    decode: (json) => _items(json, 'wards'),
  );

  static List<LocationItemDto> _items(Object? json, String key) =>
      ((json! as Map<String, dynamic>)[key]! as List<dynamic>)
          .map((e) => LocationItemDto.fromJson(e as Map<String, dynamic>))
          .toList();
}
