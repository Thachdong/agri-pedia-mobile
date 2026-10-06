import 'package:ui_ux/core/device/geo_point.dart';
import 'package:ui_ux/core/storage/token_storage.dart';
import 'package:ui_ux/features/auth/auth.dart';
import 'package:ui_ux/features/auth/data/dtos/login_request.dart';
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

/// `UserProfileResponse` JSON (openapi shape) of a DISTRIBUTOR logged in by
/// phone.
Map<String, Object?> userProfileJson({
  String id = 'u-1',
  String role = 'DISTRIBUTOR',
}) => {
  'id': id,
  'loginType': 'PHONE',
  'email': null,
  'phone': '0901234567',
  'username': 'Đại lý Minh',
  'role': role,
  'bussinessType': role == 'DISTRIBUTOR' ? 'SEEDS_SEEDLINGS' : null,
  'bussinessLicense': 'https://cdn.example.com/license?sig=1',
  'avatar': null,
  'bio': 'Giống lúa chất lượng',
  'createdAt': '2026-10-01T08:00:00.000Z',
  'updatedAt': '2026-10-02T08:00:00.000Z',
  'address': {
    'province': 'ha_noi',
    'ward': 'phuong_ba_dinh',
    'houseNumber': '12',
    'lat': 21.03,
    'long': 105.84,
  },
};

const distributorUser = CurrentUser(
  id: 'u-1',
  loginType: LoginType.phone,
  identifier: '0901234567',
  username: 'Đại lý Minh',
  role: UserRole.distributor,
  businessType: BusinessType.seedsSeedlings,
  bio: 'Giống lúa chất lượng',
);

const farmerUser = CurrentUser(
  id: 'f-1',
  loginType: LoginType.email,
  identifier: 'farmer@example.com',
  username: 'Bác Ba',
  role: UserRole.farmer,
);

const tokenPair = TokenPair(accessToken: 'acc-1', refreshToken: 'ref-1');

const loginRequest = LoginRequest(
  loginType: LoginType.email,
  identifier: 'farmer@example.com',
  password: 'secret',
);
