// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_password_reset_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConfirmPasswordResetRequest _$ConfirmPasswordResetRequestFromJson(
  Map<String, dynamic> json,
) => _ConfirmPasswordResetRequest(
  identifier: json['identifier'] as String,
  code: json['code'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$ConfirmPasswordResetRequestToJson(
  _ConfirmPasswordResetRequest instance,
) => <String, dynamic>{
  'identifier': instance.identifier,
  'code': instance.code,
  'newPassword': instance.newPassword,
};
