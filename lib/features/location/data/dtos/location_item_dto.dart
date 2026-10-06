import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_item_dto.freezed.dart';
part 'location_item_dto.g.dart';

/// A province or a ward (`LocationItemResponse`). `codename` is what the
/// server expects in `address.province` / `address.ward`.
@freezed
abstract class LocationItemDto with _$LocationItemDto {
  const factory LocationItemDto({
    required String codename,
    required String name,
  }) = _LocationItemDto;

  factory LocationItemDto.fromJson(Map<String, dynamic> json) =>
      _$LocationItemDtoFromJson(json);
}
