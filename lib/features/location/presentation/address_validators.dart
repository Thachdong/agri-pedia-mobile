import 'package:ui_ux/core/device/geo_point.dart';
import 'package:ui_ux/core/utils/validators.dart';

/// Address rules (`RegisterAddressDto`: province, ward, houseNumber ≤ 255,
/// lat/long required). Used by AddressFields.
abstract final class AddressValidators {
  static const houseNumberMaxLength = 255;

  static String? province(String? code) =>
      code == null ? 'Vui lòng chọn tỉnh/thành phố' : null;

  static String? ward(String? code) =>
      code == null ? 'Vui lòng chọn phường/xã' : null;

  static final Validator houseNumber = Validators.compose([
    Validators.required('Vui lòng nhập số nhà, tên đường'),
    Validators.maxLength(houseNumberMaxLength),
  ]);

  static String? point(GeoPoint? point) =>
      point == null ? 'Vui lòng chọn vị trí trên bản đồ' : null;
}
