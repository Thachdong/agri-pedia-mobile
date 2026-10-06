import 'package:json_annotation/json_annotation.dart';

/// `role` in openapi (auth, user, profile).
@JsonEnum(valueField: 'value')
enum UserRole {
  farmer('FARMER', label: 'Nông dân'),
  distributor('DISTRIBUTOR', label: 'Nhà phân phối');

  const UserRole(this.value, {required this.label});

  /// Server value (JSON and query params).
  final String value;
  final String label;
}
