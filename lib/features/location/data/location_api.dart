import 'package:ui_ux/core/network/api_client.dart';
import 'package:ui_ux/features/location/data/dtos/location_item_dto.dart';

class LocationApi {
  LocationApi(this._client);

  final ApiClient _client;

  /// GET /provinces — `{ provinces: [...] }`, master data order.
  Future<List<LocationItemDto>> provinces() =>
      _client.get('/provinces', decode: (json) => _items(json, 'provinces'));

  static List<LocationItemDto> _items(Object? json, String key) =>
      ((json! as Map<String, dynamic>)[key]! as List<dynamic>)
          .map((e) => LocationItemDto.fromJson(e as Map<String, dynamic>))
          .toList();
}
