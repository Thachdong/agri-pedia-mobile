// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_handoff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthHandoff _$AuthHandoffFromJson(Map<String, dynamic> json) => _AuthHandoff(
  loginType: $enumDecode(_$LoginTypeEnumMap, json['loginType']),
  identifier: json['identifier'] as String,
  at: DateTime.parse(json['at'] as String),
  purpose: $enumDecode(_$OtpPurposeEnumMap, json['purpose']),
);

Map<String, dynamic> _$AuthHandoffToJson(_AuthHandoff instance) =>
    <String, dynamic>{
      'loginType': _$LoginTypeEnumMap[instance.loginType]!,
      'identifier': instance.identifier,
      'at': instance.at.toIso8601String(),
      'purpose': _$OtpPurposeEnumMap[instance.purpose]!,
    };

const _$LoginTypeEnumMap = {LoginType.email: 'EMAIL', LoginType.phone: 'PHONE'};

const _$OtpPurposeEnumMap = {
  OtpPurpose.activateDistributor: 'ACTIVATE_DISTRIBUTOR',
  OtpPurpose.resetPassword: 'RESET_PASSWORD',
};
