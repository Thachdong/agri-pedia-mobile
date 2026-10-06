import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/features/auth/data/dtos/user_profile_dto.dart';

part 'login_response_dto.freezed.dart';
part 'login_response_dto.g.dart';

/// 200 of POST /auth/login (`LoginUserResponse`). Never log it (tokens).
@freezed
abstract class LoginResponseDto with _$LoginResponseDto {
  const factory LoginResponseDto({
    required String accessToken,
    required String refreshToken,
    required UserProfileDto user,
  }) = _LoginResponseDto;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);
}
