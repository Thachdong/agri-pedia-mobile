import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/utils/validators.dart';

void main() {
  group('email', () {
    test('valid (trimmed)', () {
      expect(Validators.email(' a@b.vn '), isNull);
    });
    test('empty / invalid', () {
      expect(Validators.email(''), 'Vui lòng nhập email');
      expect(Validators.email(null), 'Vui lòng nhập email');
      expect(Validators.email('a@b'), 'Email không hợp lệ');
      expect(Validators.email('a b@c.vn'), 'Email không hợp lệ');
    });
  });

  group('vnPhone', () {
    test('accepts +84 / 84 / 0 prefixes with separators', () {
      for (final phone in [
        '0912345678',
        '+84912345678',
        '84912345678',
        '091 234 5678',
        '(+84) 912.345-678',
      ]) {
        expect(Validators.vnPhone(phone), isNull, reason: phone);
      }
    });
    test('rejects wrong length / prefix / letters', () {
      for (final phone in [
        '091234567',
        '09123456789',
        '1912345678',
        '+85912345678',
        '09123a5678',
      ]) {
        expect(Validators.vnPhone(phone), isNotNull, reason: phone);
      }
      expect(Validators.vnPhone(''), 'Vui lòng nhập số điện thoại');
    });
  });

  group('password 8..128', () {
    test('boundaries', () {
      expect(Validators.password('a' * 7), isNotNull);
      expect(Validators.password('a' * 8), isNull);
      expect(Validators.password('a' * 128), isNull);
      expect(Validators.password('a' * 129), isNotNull);
      expect(Validators.password(''), 'Vui lòng nhập mật khẩu');
    });
    test('not trimmed', () {
      expect(Validators.password('   ab   '), isNull);
    });
  });

  test('required', () {
    final v = Validators.required('Bắt buộc');
    expect(v('  '), 'Bắt buộc');
    expect(v(null), 'Bắt buộc');
    expect(v('x'), isNull);
  });

  test('matches (confirm password)', () {
    var password = 'secret123';
    final v = Validators.matches(() => password, 'Không khớp');
    expect(v('secret123'), isNull);
    password = 'changed';
    expect(v('secret123'), 'Không khớp');
  });

  test('otp: exact digits', () {
    final v = Validators.otp();
    expect(v('123456'), isNull);
    expect(v('12345'), isNotNull);
    expect(v('12345a'), isNotNull);
    expect(Validators.otp(length: 4)('1234'), isNull);
  });

  test('maxLength counts trimmed text', () {
    final v = Validators.maxLength(5);
    expect(v('12345  '), isNull);
    expect(v('123456'), 'Tối đa 5 ký tự');
    expect(v(null), isNull);
  });

  test('compose returns the first failure', () {
    final v = Validators.compose([
      Validators.required('Bắt buộc'),
      Validators.maxLength(3, 'Dài quá'),
    ]);
    expect(v(''), 'Bắt buộc');
    expect(v('abcd'), 'Dài quá');
    expect(v('abc'), isNull);
  });
}
