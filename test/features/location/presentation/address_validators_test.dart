import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/device/geo_point.dart';
import 'package:ui_ux/features/location/presentation/address_validators.dart';

void main() {
  test('province / ward required', () {
    expect(AddressValidators.province(null), 'Vui lòng chọn tỉnh/thành phố');
    expect(AddressValidators.province('ha_noi'), isNull);
    expect(AddressValidators.ward(null), 'Vui lòng chọn phường/xã');
    expect(AddressValidators.ward('w1'), isNull);
  });

  test('houseNumber required, max 255', () {
    expect(
      AddressValidators.houseNumber('  '),
      'Vui lòng nhập số nhà, tên đường',
    );
    expect(AddressValidators.houseNumber('a' * 255), isNull);
    expect(AddressValidators.houseNumber('a' * 256), 'Tối đa 255 ký tự');
  });

  test('point required', () {
    expect(AddressValidators.point(null), 'Vui lòng chọn vị trí trên bản đồ');
    expect(AddressValidators.point(const GeoPoint(lat: 21, long: 105)), isNull);
  });
}
