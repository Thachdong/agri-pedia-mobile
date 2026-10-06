import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/presentation/controllers/register_form_input.dart';
import 'package:ui_ux/features/location/location.dart';
import 'package:ui_ux/shared/enums/business_type.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/enums/user_role.dart';

import '../../../../fixtures/auth_fixtures.dart';

void main() {
  const input = RegisterFormInput(
    loginType: LoginType.email,
    identifier: '  farmer@example.com ',
    password: ' secret123 ',
    username: '   ',
    role: UserRole.farmer,
    bio: '',
    address: completeAddress,
  );

  group('toRequest', () {
    test('trims text, keeps password as typed, drops empty optionals', () {
      final request = input.toRequest();

      expect(request.identifier, 'farmer@example.com');
      expect(request.password, ' secret123 ');
      expect(request.username, isNull);
      expect(request.bio, isNull);
      expect(request.address.houseNumber, '12 Nguyễn Trãi');
      expect(request.address.province, 'ha_noi');
      expect(request.address.ward, 'phuong_ba_dinh');
      expect(request.address.lat, 21.03);
      expect(request.address.long, 105.84);
    });

    test('non-empty optionals are trimmed and sent', () {
      final request = input
          .copyWith(username: ' NPP A ', bio: ' Giống lúa ')
          .toRequest();

      expect(request.username, 'NPP A');
      expect(request.bio, 'Giống lúa');
    });

    test('FARMER always sends bussinessType null', () {
      final request = input
          .copyWith(bussinessType: BusinessType.seedsSeedlings)
          .toRequest();

      expect(request.bussinessType, isNull);
    });

    test('DISTRIBUTOR keeps bussinessType', () {
      final request = input
          .copyWith(
            role: UserRole.distributor,
            bussinessType: BusinessType.aquacultureSeedlings,
          )
          .toRequest();

      expect(request.bussinessType, BusinessType.aquacultureSeedlings);
    });

    test('incomplete address → StateError', () {
      for (final address in [
        completeAddress.copyWith(provinceCode: null),
        completeAddress.copyWith(wardCode: null),
        completeAddress.copyWith(houseNumber: '  '),
        completeAddress.copyWith(point: null),
        const AddressInput(),
      ]) {
        expect(
          () => input.copyWith(address: address).toRequest(),
          throwsStateError,
          reason: '$address',
        );
      }
    });
  });

  group('registerErrorFieldOf', () {
    ApiException error(String code) =>
        ApiException(code: code, message: code, statusCode: 400);

    test('maps each register code to its field', () {
      expect(
        registerErrorFieldOf(error('USER_IDENTIFIER_ALREADY_USED')),
        RegisterErrorField.identifier,
      );
      expect(
        registerErrorFieldOf(error('USER_BUSINESS_TYPE_REQUIRED')),
        RegisterErrorField.bussinessType,
      );
      expect(
        registerErrorFieldOf(error('USER_BUSINESS_TYPE_NOT_ALLOWED')),
        RegisterErrorField.bussinessType,
      );
      expect(
        registerErrorFieldOf(error('USER_LOCATION_INVALID')),
        RegisterErrorField.address,
      );
      expect(
        registerErrorFieldOf(error('USER_INVALID_COORDINATES')),
        RegisterErrorField.address,
      );
    });

    test('other codes and non-API errors → form', () {
      expect(
        registerErrorFieldOf(error(ApiException.networkError)),
        RegisterErrorField.form,
      );
      expect(
        registerErrorFieldOf(error(ApiException.validationFailed)),
        RegisterErrorField.form,
      );
      expect(registerErrorFieldOf(StateError('x')), RegisterErrorField.form);
    });
  });
}
