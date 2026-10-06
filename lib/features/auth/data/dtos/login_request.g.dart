// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    _LoginRequest(
      loginType: $enumDecode(_$LoginTypeEnumMap, json['loginType']),
      identifier: json['identifier'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(_LoginRequest instance) =>
    <String, dynamic>{
      'loginType': _$LoginTypeEnumMap[instance.loginType]!,
      'identifier': instance.identifier,
      'password': instance.password,
    };

const _$LoginTypeEnumMap = {LoginType.email: 'EMAIL', LoginType.phone: 'PHONE'};
