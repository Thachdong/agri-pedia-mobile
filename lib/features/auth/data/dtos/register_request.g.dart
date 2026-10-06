// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    _RegisterRequest(
      loginType: $enumDecode(_$LoginTypeEnumMap, json['loginType']),
      identifier: json['identifier'] as String,
      password: json['password'] as String,
      username: json['username'] as String?,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      bussinessType: $enumDecodeNullable(
        _$BusinessTypeEnumMap,
        json['bussinessType'],
      ),
      bio: json['bio'] as String?,
      address: RegisterAddressRequest.fromJson(
        json['address'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$RegisterRequestToJson(_RegisterRequest instance) =>
    <String, dynamic>{
      'loginType': _$LoginTypeEnumMap[instance.loginType]!,
      'identifier': instance.identifier,
      'password': instance.password,
      'username': ?instance.username,
      'role': _$UserRoleEnumMap[instance.role]!,
      'bussinessType': _$BusinessTypeEnumMap[instance.bussinessType],
      'bio': ?instance.bio,
      'address': instance.address.toJson(),
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

_RegisterAddressRequest _$RegisterAddressRequestFromJson(
  Map<String, dynamic> json,
) => _RegisterAddressRequest(
  province: json['province'] as String,
  ward: json['ward'] as String,
  houseNumber: json['houseNumber'] as String,
  lat: (json['lat'] as num).toDouble(),
  long: (json['long'] as num).toDouble(),
);

Map<String, dynamic> _$RegisterAddressRequestToJson(
  _RegisterAddressRequest instance,
) => <String, dynamic>{
  'province': instance.province,
  'ward': instance.ward,
  'houseNumber': instance.houseNumber,
  'lat': instance.lat,
  'long': instance.long,
};
