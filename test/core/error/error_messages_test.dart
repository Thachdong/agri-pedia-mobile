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
}
