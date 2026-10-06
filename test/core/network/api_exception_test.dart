import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/network/api_exception.dart';

void main() {
  group('ApiException.fromBody', () {
    test('parses domain error shape', () {
      final e = ApiException.fromBody({
        'statusCode': 403,
        'code': 'OTP_BLOCKED',
        'message': 'Blocked',
        'details': {'blockUntil': '2026-10-06T10:00:00Z'},
      });
      expect(e.statusCode, 403);
      expect(e.code, 'OTP_BLOCKED');
      expect(e.message, 'Blocked');
      expect(e.details, {'blockUntil': '2026-10-06T10:00:00Z'});
    });

    test('parses validation shape into VALIDATION_FAILED', () {
      final e = ApiException.fromBody({
        'statusCode': 400,
        'message': ['password too short', 'identifier invalid'],
        'error': 'Bad Request',
      });
      expect(e.code, ApiException.validationFailed);
      expect(e.statusCode, 400);
      expect(e.message, 'password too short\nidentifier invalid');
    });

    test('parses realtime ack error shape', () {
      final e = ApiException.fromBody({
        'error': {'code': 'CHAT_ROOM_NOT_FOUND', 'message': 'Not found'},
      });
      expect(e.code, 'CHAT_ROOM_NOT_FOUND');
      expect(e.statusCode, isNull);
    });

    test('falls back to statusCode argument and UNKNOWN', () {
      final e = ApiException.fromBody('<html>502</html>', statusCode: 502);
      expect(e.code, ApiException.unknown);
      expect(e.statusCode, 502);
    });

    test('message defaults to code when missing', () {
      final e = ApiException.fromBody({'code': 'USER_NOT_FOUND'});
      expect(e.message, 'USER_NOT_FOUND');
    });

    test('isUnauthorized only for 401', () {
      expect(
        const ApiException(
          code: 'X',
          message: '',
          statusCode: 401,
        ).isUnauthorized,
        isTrue,
      );
      expect(
        const ApiException(
          code: 'X',
          message: '',
          statusCode: 403,
        ).isUnauthorized,
        isFalse,
      );
    });
  });
}
