// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activate_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivateRequest _$ActivateRequestFromJson(Map<String, dynamic> json) =>
    _ActivateRequest(
      identifier: json['identifier'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$ActivateRequestToJson(_ActivateRequest instance) =>
    <String, dynamic>{'identifier': instance.identifier, 'code': instance.code};
