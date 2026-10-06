// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileDto _$UserProfileDtoFromJson(Map<String, dynamic> json) =>
    _UserProfileDto(
      id: json['id'] as String,
      loginType: $enumDecode(_$LoginTypeEnumMap, json['loginType']),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      username: json['username'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      bussinessType: $enumDecodeNullable(
        _$BusinessTypeEnumMap,
        json['bussinessType'],
      ),
      bussinessLicense: json['bussinessLicense'] as String?,
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      address: json['address'] == null
          ? null
          : UserAddressDto.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileDtoToJson(_UserProfileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'loginType': _$LoginTypeEnumMap[instance.loginType]!,
      'email': instance.email,
      'phone': instance.phone,
      'username': instance.username,
      'role': _$UserRoleEnumMap[instance.role]!,
      'bussinessType': _$BusinessTypeEnumMap[instance.bussinessType],
      'bussinessLicense': instance.bussinessLicense,
      'avatar': instance.avatar,
      'bio': instance.bio,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'address': instance.address?.toJson(),
    };

const _$LoginTypeEnumMap = {LoginType.email: 'EMAIL', LoginType.phone: 'PHONE'};

const _$UserRoleEnumMap = {
  UserRole.farmer: 'FARMER',
  UserRole.distributor: 'DISTRIBUTOR',
};

const _$BusinessTypeEnumMap = {
  BusinessType.agriculturalChemicalSupplies: 'AGRICULTURAL_CHEMICAL_SUPPLIES',
  BusinessType.seedsSeedlings: 'SEEDS_SEEDLINGS',
  BusinessType.aquacultureSeedlings: 'AQUACULTURE_SEEDLINGS',
};

_UserAddressDto _$UserAddressDtoFromJson(Map<String, dynamic> json) =>
    _UserAddressDto(
      province: json['province'] as String,
      ward: json['ward'] as String,
      houseNumber: json['houseNumber'] as String,
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
    );

Map<String, dynamic> _$UserAddressDtoToJson(_UserAddressDto instance) =>
    <String, dynamic>{
      'province': instance.province,
      'ward': instance.ward,
      'houseNumber': instance.houseNumber,
      'lat': instance.lat,
      'long': instance.long,
    };
