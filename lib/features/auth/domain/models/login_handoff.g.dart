// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_handoff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginHandoff _$LoginHandoffFromJson(Map<String, dynamic> json) =>
    _LoginHandoff(
      loginType: $enumDecode(_$LoginTypeEnumMap, json['loginType']),
      identifier: json['identifier'] as String,
    );

Map<String, dynamic> _$LoginHandoffToJson(_LoginHandoff instance) =>
    <String, dynamic>{
      'loginType': _$LoginTypeEnumMap[instance.loginType]!,
      'identifier': instance.identifier,
    };

const _$LoginTypeEnumMap = {LoginType.email: 'EMAIL', LoginType.phone: 'PHONE'};
