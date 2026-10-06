import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/network/debug_log_interceptor.dart';

class _Adapter implements HttpClientAdapter {
  _Adapter(this.status, this.body);

  final int status;
  final Object? body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString(
    jsonEncode(body),
    status,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );

  @override
  void close({bool force = false}) {}
}

void main() {
  group('redactSensitive', () {
    test('masks secrets at any depth, keeps the rest', () {
      expect(
        redactSensitive({
          'identifier': 'a@b.vn',
          'password': 'p@ss',
          'nested': {
            'refreshToken': 'r',
            'items': [
              {'code': '123456', 'codename': 'ha_noi'},
            ],
          },
        }),
        {
          'identifier': 'a@b.vn',
          'password': '***',
          'nested': {
            'refreshToken': '***',
            'items': [
              {'code': '***', 'codename': 'ha_noi'},
            ],
          },
        },
      );
    });

    test('non-JSON bodies print their type only', () {
      expect(redactSensitive(FormData()), '<FormData>');
    });
  });

  group('DebugLogInterceptor', () {
    late List<String> lines;

    Dio dio(int status, Object? body) {
      lines = [];
      return Dio(BaseOptions(baseUrl: 'http://test'))
        ..httpClientAdapter = _Adapter(status, body)
        ..interceptors.add(DebugLogInterceptor(log: lines.add));
    }

    test('never prints password, tokens or the auth header', () async {
      await dio(200, {'accessToken': 'ACC', 'refreshToken': 'REF'}).post<void>(
        '/auth/login',
        data: {'identifier': 'a@b.vn', 'password': 'SECRET'},
        options: Options(headers: {'Authorization': 'Bearer ACC'}),
      );

      final log = lines.join('\n');
      expect(log, contains('POST http://test/auth/login'));
      expect(log, contains('← 200'));
      for (final secret in ['SECRET', 'ACC', 'REF', 'Bearer']) {
        expect(log, isNot(contains(secret)), reason: secret);
      }
    });

    test('errors log status and server code', () async {
      await expectLater(
        dio(401, {
          'code': 'USER_INVALID_CREDENTIALS',
        }).post<void>('/auth/login'),
        throwsA(isA<DioException>()),
      );
      expect(lines.last, contains('✕ 401'));
      expect(lines.last, contains('USER_INVALID_CREDENTIALS'));
    });
  });
}
