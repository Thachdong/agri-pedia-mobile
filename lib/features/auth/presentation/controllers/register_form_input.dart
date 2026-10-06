import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/dtos/register_request.dart';
import 'package:ui_ux/features/location/location.dart';
import 'package:ui_ux/shared/enums/business_type.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/enums/user_role.dart';

part 'register_form_input.freezed.dart';

/// Register form values as typed; [toRequest] applies the submit rules.
/// `confirmPassword` is validated in the form only and never kept here.
@freezed
abstract class RegisterFormInput with _$RegisterFormInput {
  const factory RegisterFormInput({
    required LoginType loginType,
    required String identifier,
    required String password,
    @Default('') String username,
    required UserRole role,
    BusinessType? bussinessType,
    @Default('') String bio,
    required AddressInput address,
  }) = _RegisterFormInput;

  const RegisterFormInput._();

  /// Trims text, drops empty optionals, forces `bussinessType` null for
  /// FARMER (even if one was picked before switching role).
  /// Call after the form validated: throws [StateError] on an incomplete
  /// address.
  RegisterRequest toRequest() {
    final point = address.point;
    final province = address.provinceCode;
    final ward = address.wardCode;
    if (!address.isComplete ||
        point == null ||
        province == null ||
        ward == null) {
      throw StateError('Address is incomplete; validate the form first.');
    }
    return RegisterRequest(
      loginType: loginType,
      identifier: identifier.trim(),
      password: password,
      username: _orNull(username),
      role: role,
      bussinessType: role == UserRole.distributor ? bussinessType : null,
      bio: _orNull(bio),
      address: RegisterAddressRequest(
        province: province,
        ward: ward,
        houseNumber: address.houseNumber.trim(),
        lat: point.lat,
        long: point.long,
      ),
    );
  }

  static String? _orNull(String value) {
    final v = value.trim();
    return v.isEmpty ? null : v;
  }
}

/// Where a register server error is shown.
enum RegisterErrorField { identifier, bussinessType, address, form }

const _fieldByCode = <String, RegisterErrorField>{
  'USER_IDENTIFIER_ALREADY_USED': RegisterErrorField.identifier,
  'USER_BUSINESS_TYPE_REQUIRED': RegisterErrorField.bussinessType,
  'USER_BUSINESS_TYPE_NOT_ALLOWED': RegisterErrorField.bussinessType,
  'USER_LOCATION_INVALID': RegisterErrorField.address,
  'USER_INVALID_COORDINATES': RegisterErrorField.address,
};

/// Field that should display [error]; text comes from `errorMessageOf`.
RegisterErrorField registerErrorFieldOf(Object error) => switch (error) {
  ApiException(:final code) => _fieldByCode[code] ?? RegisterErrorField.form,
  _ => RegisterErrorField.form,
};
