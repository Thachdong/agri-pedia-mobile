import 'package:ui_ux/core/device/geo_point.dart';
import 'package:ui_ux/features/auth/data/dtos/register_request.dart';
import 'package:ui_ux/features/location/location.dart';
import 'package:ui_ux/shared/enums/business_type.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/enums/user_role.dart';

const completeAddress = AddressInput(
  provinceCode: 'ha_noi',
  wardCode: 'phuong_ba_dinh',
  houseNumber: '  12 Nguyễn Trãi ',
  point: GeoPoint(lat: 21.03, long: 105.84),
);

const farmerRequest = RegisterRequest(
  loginType: LoginType.email,
  identifier: 'farmer@example.com',
  password: 'secret123',
  role: UserRole.farmer,
  address: RegisterAddressRequest(
    province: 'ha_noi',
    ward: 'phuong_ba_dinh',
    houseNumber: '12 Nguyễn Trãi',
    lat: 21.03,
    long: 105.84,
  ),
);

final distributorRequest = farmerRequest.copyWith(
  loginType: LoginType.phone,
  identifier: '0901234567',
  role: UserRole.distributor,
  bussinessType: BusinessType.seedsSeedlings,
);
