import 'package:ui_ux/core/network/api_exception.dart';

/// Vietnamese text for an error, for display under forms, in snackbars and
/// error views. Widgets never compare error codes themselves.
///
/// Lookup order: [_messages] by code → by HTTP status → generic text.
/// Server `message` is developer text (English) and is not shown.
String errorMessageOf(Object? error) {
  if (error is ApiException) {
    if (_blockedUntil(error) case final until?) {
      return 'Bạn đã thử quá nhiều lần. Vui lòng thử lại sau ${_hhmm(until)}.';
    }
    return _messages[error.code] ?? _byStatus(error.statusCode) ?? _generic;
  }
  return _generic;
}

/// `OTP_BLOCKED` may carry `details.blockUntil` (ISO date), shown in local
/// time.
DateTime? _blockedUntil(ApiException error) {
  if (error.code != 'OTP_BLOCKED') return null;
  final raw = error.details?['blockUntil'];
  return raw is String ? DateTime.tryParse(raw)?.toLocal() : null;
}

String _hhmm(DateTime t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

const _generic = 'Đã có lỗi xảy ra. Vui lòng thử lại.';

String? _byStatus(int? status) => switch (status) {
  401 => 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
  403 => 'Bạn không có quyền thực hiện thao tác này.',
  404 => 'Không tìm thấy dữ liệu.',
  429 => 'Bạn thao tác quá nhanh. Vui lòng thử lại sau.',
  final s? when s >= 500 => 'Hệ thống đang bận. Vui lòng thử lại sau.',
  _ => null,
};

/// Server domain codes (see `openapi.py op` error lists) + client codes.
/// Add a feature's codes when connecting its endpoints (mb-feature-api).
const _messages = <String, String>{
  // Client
  ApiException.networkError:
      'Không có kết nối mạng. Vui lòng kiểm tra và thử lại.',
  ApiException.timeout: 'Kết nối quá chậm. Vui lòng thử lại.',
  ApiException.invalidResponse: 'Dữ liệu trả về không hợp lệ.',
  ApiException.validationFailed: 'Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.',
  // Session
  'AUTH_INVALID_ACCESS_TOKEN':
      'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
  'USER_INVALID_REFRESH_TOKEN':
      'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
  // Register
  'USER_IDENTIFIER_ALREADY_USED':
      'Email/số điện thoại này đã được dùng để đăng ký.',
  'USER_INVALID_COORDINATES': 'Toạ độ không hợp lệ. Vui lòng chọn lại vị trí.',
  'USER_LOCATION_INVALID':
      'Tỉnh/thành phố hoặc phường/xã không hợp lệ. Vui lòng chọn lại.',
  'USER_BUSINESS_TYPE_REQUIRED': 'Vui lòng chọn loại hình kinh doanh.',
  'USER_BUSINESS_TYPE_NOT_ALLOWED':
      'Nông dân không cần chọn loại hình kinh doanh.',
  // OTP (activate, resend, change-password)
  'OTP_INVALID_CODE': 'Mã xác thực không đúng.',
  'OTP_NOT_FOUND': 'Không tìm thấy mã xác thực cho tài khoản này.',
  'OTP_ALREADY_CONSUMED': 'Mã xác thực đã được sử dụng.',
  'OTP_EXPIRED': 'Mã xác thực đã hết hạn. Vui lòng gửi lại mã mới.',
  'OTP_BLOCKED': 'Bạn đã thử quá nhiều lần. Vui lòng thử lại sau.',
  // Location
  'LOCATION_PROVINCE_NOT_FOUND': 'Không tìm thấy tỉnh/thành phố.',
};
