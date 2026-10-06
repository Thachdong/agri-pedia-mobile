import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/features/auth/presentation/auth_validators.dart';
import 'package:ui_ux/shared/enums/business_type.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/enums/user_role.dart';

void main() {
  group('identifier', () {
    final email = AuthValidators.identifier(LoginType.email);
    final phone = AuthValidators.identifier(LoginType.phone);

    test('EMAIL tab validates email', () {
      expect(email('a@b.vn'), isNull);
      expect(email(' a@b.vn '), isNull);
      expect(email(''), 'Vui lòng nhập email');
      expect(email('0901234567'), 'Email không hợp lệ');
    });

    test('PHONE tab validates VN phone with separators', () {
      for (final ok in [
        '0901234567',
        '+84901234567',
        '84901234567',
        '090 123 4567',
        '090.123.4567',
        '(090) 123-4567',
      ]) {
        expect(phone(ok), isNull, reason: ok);
      }
      expect(phone(''), 'Vui lòng nhập số điện thoại');
      expect(phone('090123456'), 'Số điện thoại không hợp lệ');
      expect(phone('a@b.vn'), 'Số điện thoại không hợp lệ');
    });

    test('max 255 chars', () {
      final long = '${'a' * 250}@b.vn'; // 255
      expect(email(long), isNull);
      expect(email('a$long'), 'Tối đa 255 ký tự');
    });
  });

  test('username: optional, max 100', () {
    expect(AuthValidators.username(''), isNull);
    expect(AuthValidators.username(null), isNull);
    expect(AuthValidators.username('a' * 100), isNull);
    expect(AuthValidators.username('a' * 101), 'Tối đa 100 ký tự');
  });

  test('bio: optional, max 1000', () {
    expect(AuthValidators.bio(''), isNull);
    expect(AuthValidators.bio('a' * 1000), isNull);
    expect(AuthValidators.bio('a' * 1001), 'Tối đa 1000 ký tự');
  });

  test('confirmPassword: required and must match', () {
    var password = 'secret123';
    final confirm = AuthValidators.confirmPassword(() => password);

    expect(confirm(''), 'Vui lòng nhập lại mật khẩu');
    expect(confirm('secret124'), 'Mật khẩu xác nhận không khớp');
    expect(confirm('secret123'), isNull);
    password = 'changed!';
    expect(confirm('secret123'), 'Mật khẩu xác nhận không khớp');
  });

  test('businessType: required for DISTRIBUTOR only', () {
    final distributor = AuthValidators.businessType(UserRole.distributor);
    final farmer = AuthValidators.businessType(UserRole.farmer);

    expect(distributor(null), 'Vui lòng chọn loại hình kinh doanh');
    expect(distributor(BusinessType.seedsSeedlings), isNull);
    expect(farmer(null), isNull);
  });

  test('otpCode: exactly 6 digits', () {
    const message = 'Vui lòng nhập đủ 6 chữ số';
    expect(AuthValidators.otpCode('123456'), isNull);
    expect(AuthValidators.otpCode(' 123456 '), isNull);
    for (final bad in ['', '12345', '1234567', '12a456', '12 456']) {
      expect(AuthValidators.otpCode(bad), message, reason: bad);
    }
  });

  test('loginPassword: required, max 128, no strength rule', () {
    expect(AuthValidators.loginPassword(''), 'Vui lòng nhập mật khẩu');
    expect(AuthValidators.loginPassword(null), 'Vui lòng nhập mật khẩu');
    expect(AuthValidators.loginPassword('a'), isNull);
    expect(AuthValidators.loginPassword('1234567'), isNull);
    expect(AuthValidators.loginPassword('a' * 128), isNull);
    expect(AuthValidators.loginPassword('a' * 129), isNotNull);
  });
}
