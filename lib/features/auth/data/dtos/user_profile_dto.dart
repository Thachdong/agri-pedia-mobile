import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/shared/enums/business_type.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/enums/user_role.dart';

part 'user_profile_dto.freezed.dart';
part 'user_profile_dto.g.dart';

/// `UserProfileResponse`: GET /users/me and `user` of POST /auth/login.
/// `email` / `phone`: the login identifier (the other one is null).
/// `bussinessLicense`: signed read URL (expires). Spec spelling kept.
@freezed
abstract class UserProfileDto with _$UserProfileDto {
  const factory UserProfileDto({
    required String id,
    required LoginType loginType,
    required String? email,
    required String? phone,
    required String username,
    required UserRole role,
    required BusinessType? bussinessType,
    required String? bussinessLicense,
    required String? avatar,
    required String? bio,
    required DateTime createdAt,
    required DateTime updatedAt,
    required UserAddressDto? address,
  }) = _UserProfileDto;

  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);
}

/// `UserAddressResponse`: the primary address.
@freezed
abstract class UserAddressDto with _$UserAddressDto {
  const factory UserAddressDto({
    required String province,
    required String ward,
    required String houseNumber,
    required double lat,
    required double long,
  }) = _UserAddressDto;

  factory UserAddressDto.fromJson(Map<String, dynamic> json) =>
      _$UserAddressDtoFromJson(json);
}
