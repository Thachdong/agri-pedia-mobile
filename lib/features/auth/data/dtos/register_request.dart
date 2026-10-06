import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/shared/enums/business_type.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/enums/user_role.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

/// Body of POST /auth/register (`RegisterUserDto`).
@freezed
abstract class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required LoginType loginType,
    required String identifier,
    required String password,
    @JsonKey(includeIfNull: false) String? username,
    required UserRole role,

    /// Required for DISTRIBUTOR, null for FARMER (sent as `null`).
    BusinessType? bussinessType,
    @JsonKey(includeIfNull: false) String? bio,
    required RegisterAddressRequest address,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}

/// `RegisterAddressDto`. `province` / `ward` are codenames from
/// GET /provinces and GET /provinces/{provinceCode}/wards. `isPrimary` is
/// ignored by the server (first address is always primary), so not sent.
@freezed
abstract class RegisterAddressRequest with _$RegisterAddressRequest {
  const factory RegisterAddressRequest({
    required String province,
    required String ward,
    required String houseNumber,
    required double lat,
    required double long,
  }) = _RegisterAddressRequest;

  factory RegisterAddressRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterAddressRequestFromJson(json);
}
