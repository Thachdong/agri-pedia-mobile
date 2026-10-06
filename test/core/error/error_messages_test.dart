import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/error/error_messages.dart';
import 'package:ui_ux/core/network/api_exception.dart';

ApiException _e(String code, [int? status]) =>
    ApiException(code: code, message: 'server text', statusCode: status);

void main() {
  test('known code → Vietnamese message', () {
    expect(
      errorMessageOf(_e(ApiException.networkError)),
      contains('Không có kết nối mạng'),
    );
  });

  test('unknown code → message by HTTP status', () {
    expect(errorMessageOf(_e('X', 404)), 'Không tìm thấy dữ liệu.');
    expect(errorMessageOf(_e('X', 503)), contains('Hệ thống đang bận'));
  });

  test('never shows server developer text', () {
    expect(errorMessageOf(_e('X', 418)), isNot(contains('server text')));
  });

  test('non-API errors → generic message', () {
    expect(errorMessageOf(StateError('x')), contains('Đã có lỗi xảy ra'));
    expect(errorMessageOf(null), contains('Đã có lỗi xảy ra'));
  });

  group('OTP_BLOCKED', () {
    test('with details.blockUntil → local HH:mm', () {
      final until = DateTime(2026, 10, 6, 9, 5);
      final error = ApiException(
        code: 'OTP_BLOCKED',
        message: 'blocked',
        statusCode: 422,
        details: {'blockUntil': until.toUtc().toIso8601String()},
      );
      expect(
        errorMessageOf(error),
        'Bạn đã thử quá nhiều lần. Vui lòng thử lại sau 09:05.',
      );
    });

    test('without / invalid blockUntil → generic blocked text', () {
      const generic = 'Bạn đã thử quá nhiều lần. Vui lòng thử lại sau.';
      expect(errorMessageOf(_e('OTP_BLOCKED', 422)), generic);
      expect(
        errorMessageOf(
          const ApiException(
            code: 'OTP_BLOCKED',
            message: 'blocked',
            details: {'blockUntil': 'not a date'},
          ),
        ),
        generic,
      );
    });
  });
}
