// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_code_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResendCodeRequest _$ResendCodeRequestFromJson(Map<String, dynamic> json) =>
    _ResendCodeRequest(
      identifier: json['identifier'] as String,
      purpose: $enumDecode(_$OtpPurposeEnumMap, json['purpose']),
    );

Map<String, dynamic> _$ResendCodeRequestToJson(_ResendCodeRequest instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'purpose': _$OtpPurposeEnumMap[instance.purpose]!,
    };

const _$OtpPurposeEnumMap = {
  OtpPurpose.activateDistributor: 'ACTIVATE_DISTRIBUTOR',
  OtpPurpose.resetPassword: 'RESET_PASSWORD',
};
