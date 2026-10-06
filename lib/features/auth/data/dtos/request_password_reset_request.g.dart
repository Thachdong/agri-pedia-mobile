// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_password_reset_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequestPasswordResetRequest _$RequestPasswordResetRequestFromJson(
  Map<String, dynamic> json,
) => _RequestPasswordResetRequest(
  loginType: $enumDecode(_$LoginTypeEnumMap, json['loginType']),
  identifier: json['identifier'] as String,
);

Map<String, dynamic> _$RequestPasswordResetRequestToJson(
  _RequestPasswordResetRequest instance,
) => <String, dynamic>{
  'loginType': _$LoginTypeEnumMap[instance.loginType]!,
  'identifier': instance.identifier,
};

const _$LoginTypeEnumMap = {LoginType.email: 'EMAIL', LoginType.phone: 'PHONE'};
