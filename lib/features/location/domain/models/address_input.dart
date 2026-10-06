import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/core/device/geo_point.dart';

part 'address_input.freezed.dart';

/// Value of the address form section (AddressFields) while editing.
/// Fields stay nullable until chosen; [isComplete] gates submit.
@freezed
abstract class AddressInput with _$AddressInput {
  const factory AddressInput({
    /// Province `codename` (GET /provinces).
    String? provinceCode,

    /// Ward `codename` of [provinceCode]; reset when the province changes.
    String? wardCode,
    @Default('') String houseNumber,
    GeoPoint? point,
  }) = _AddressInput;

  const AddressInput._();

  bool get isComplete =>
      provinceCode != null &&
      wardCode != null &&
      houseNumber.trim().isNotEmpty &&
      point != null;
}
