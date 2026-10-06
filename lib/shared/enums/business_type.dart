import 'package:json_annotation/json_annotation.dart';

/// `bussinessType` in openapi (spec spelling): required for DISTRIBUTOR,
/// null for FARMER. Used by auth (register), user, distributor, profile.
@JsonEnum(valueField: 'value')
enum BusinessType {
  agriculturalChemicalSupplies(
    'AGRICULTURAL_CHEMICAL_SUPPLIES',
    label: 'Vật tư nông nghiệp (phân bón, thuốc BVTV)',
  ),
  seedsSeedlings('SEEDS_SEEDLINGS', label: 'Giống cây trồng'),
  aquacultureSeedlings('AQUACULTURE_SEEDLINGS', label: 'Giống thuỷ sản');

  const BusinessType(this.value, {required this.label});

  /// Server value (JSON and query params).
  final String value;
  final String label;
}
