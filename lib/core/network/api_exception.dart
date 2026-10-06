/// Every failure of an API call (HTTP or realtime) surfaces as this type.
///
/// [code] is the server domain code (`USER_INVALID_CREDENTIALS`, `OTP_BLOCKED`...)
/// or one of the client codes below. UI turns it into text with
/// `errorMessageOf` (core/error/error_messages.dart).
class ApiException implements Exception {
  const ApiException({
    required this.code,
    required this.message,
    this.statusCode,
    this.details,
  });

  /// Parses a server error body.
  ///
  /// Handles the domain shape `{statusCode, code, message, details}`, the
  /// validation shape `{statusCode, message: string[], error}` and the realtime
  /// ack shape `{error: {code, message, details}}`.
  factory ApiException.fromBody(Object? body, {int? statusCode}) {
    if (body is Map<String, Object?>) {
      final nested = body['error'];
      if (nested is Map<String, Object?>) {
        return ApiException.fromBody(nested, statusCode: statusCode);
      }
      final status = body['statusCode'] is int
          ? body['statusCode'] as int
          : statusCode;
      final code = body['code'];
      final message = body['message'];
      if (code is String) {
        final details = body['details'];
        return ApiException(
          statusCode: status,
          code: code,
          message: message is String ? message : code,
          details: details is Map<String, Object?> ? details : null,
        );
      }
      if (message is List) {
        return ApiException(
          statusCode: status,
          code: validationFailed,
          message: message.join('\n'),
        );
      }
    }
    return ApiException(
      statusCode: statusCode,
      code: unknown,
      message: 'Unexpected error response',
    );
  }

  // Client-side codes (not sent by the server).
  static const networkError = 'NETWORK_ERROR';
  static const timeout = 'TIMEOUT';
  static const cancelled = 'CANCELLED';
  static const invalidResponse = 'INVALID_RESPONSE';
  static const validationFailed = 'VALIDATION_FAILED';
  static const unknown = 'UNKNOWN';

  final int? statusCode;
  final String code;
  final String message;
  final Map<String, Object?>? details;

  bool get isUnauthorized => statusCode == 401;

  @override
  String toString() => 'ApiException($statusCode $code: $message)';
}
