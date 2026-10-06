import 'package:json_annotation/json_annotation.dart';

/// How a user identifies: `loginType` in openapi (auth, user).
@JsonEnum(valueField: 'value')
enum LoginType {
  email('EMAIL', tabLabel: 'EMAIL', identifierLabel: 'Email'),
  phone('PHONE', tabLabel: 'PHONE', identifierLabel: 'Số điện thoại');

  const LoginType(
    this.value, {
    required this.tabLabel,
    required this.identifierLabel,
  });

  /// Server value (JSON and query params).
  final String value;

  /// Tab text per wireframe (EMAIL | PHONE).
  final String tabLabel;

  /// Label of the identifier input.
  final String identifierLabel;
}
