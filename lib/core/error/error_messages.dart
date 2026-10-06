import 'package:ui_ux/core/network/api_exception.dart';

/// Vietnamese text for an error, for display under forms, in snackbars and
/// error views. Widgets never compare error codes themselves.
///
/// Lookup order: [_messages] by code → by HTTP status → generic text.
/// Server `message` is developer text (English) and is not shown.
String errorMessageOf(Object? error) {
  if (error is ApiException) {
    return _messages[error.code] ??
        _byStatus(error.statusCode) ??
        _generic;
  }
  return _generic;
}

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
  ApiException.validationFailed:
      'Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.',
  // Session
  'AUTH_INVALID_ACCESS_TOKEN':
      'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
  'USER_INVALID_REFRESH_TOKEN':
      'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
};
