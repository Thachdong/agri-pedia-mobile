import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/core/network/api_client.dart';
import 'package:ui_ux/features/location/data/dtos/location_item_dto.dart';
import 'package:ui_ux/features/location/data/location_api.dart';
import 'package:ui_ux/features/location/data/location_repository.dart';

class _MockApiClient extends Mock implements ApiClient {}

void main() {
  late _MockApiClient client;
  late LocationRepository repository;

  setUp(() {
    client = _MockApiClient();
    repository = LocationRepository(LocationApi(client));
  });

  /// Stubs GET [path] and answers by running the repository's own decoder
  /// on [body], so the list key + DTO mapping are exercised.
  void stubGet(String path, Map<String, Object?> body) {
    when(
      () =>
          client.get<List<LocationItemDto>>(path, decode: any(named: 'decode')),
    ).thenAnswer((invocation) async {
      final decode =
          invocation.namedArguments[#decode]
              as JsonDecode<List<LocationItemDto>>;
      return decode(body);
    });
  }

  test('provinces: GET /provinces, decodes the `provinces` list', () async {
    stubGet('/provinces', {
      'provinces': [
        {'codename': 'ha_noi', 'name': 'Hà Nội'},
        {'codename': 'da_nang', 'name': 'Đà Nẵng'},
      ],
    });

    expect(await repository.provinces(), const [
      LocationItemDto(codename: 'ha_noi', name: 'Hà Nội'),
      LocationItemDto(codename: 'da_nang', name: 'Đà Nẵng'),
    ]);
  });

  test(
    'wards: GET /provinces/{code}/wards, decodes the `wards` list',
    () async {
      stubGet('/provinces/ha_noi/wards', {
        'wards': [
          {'codename': 'phuong_ba_dinh', 'name': 'Phường Ba Đình'},
        ],
      });

      expect(await repository.wards('ha_noi'), const [
        LocationItemDto(codename: 'phuong_ba_dinh', name: 'Phường Ba Đình'),
      ]);
    },
  );

  test('empty list → empty result', () async {
    stubGet('/provinces', {'provinces': <Object?>[]});

    expect(await repository.provinces(), isEmpty);
  });
}
