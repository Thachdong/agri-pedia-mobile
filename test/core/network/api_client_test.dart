import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/network/api_client.dart';
import 'package:ui_ux/core/network/api_exception.dart';

/// Answers every request with [handler]; records the last request.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.handler);

  final Future<ResponseBody> Function(RequestOptions options) handler;
  RequestOptions? last;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    last = options;
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _json(Object? body, int status) => ResponseBody.fromString(
  jsonEncode(body),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

void main() {
  late _FakeAdapter adapter;
  late ApiClient client;

  void respond(Future<ResponseBody> Function(RequestOptions) handler) {
    adapter = _FakeAdapter(handler);
    final dio = Dio(BaseOptions(baseUrl: 'http://test'))
      ..httpClientAdapter = adapter;
    client = ApiClient(dio);
  }

  test('get decodes body and drops null query params', () async {
    respond((_) async => _json({'id': 'p1'}, 200));

    final id = await client.get(
      '/products/p1',
      query: {'cursor': null, 'limit': 20},
      decode: (json) => (json! as Map<String, Object?>)['id']! as String,
    );

    expect(id, 'p1');
    expect(adapter.last!.method, 'GET');
    expect(adapter.last!.queryParameters, {'limit': 20});
  });

  test('post sends body; void result without decode', () async {
    respond((_) async => _json(null, 201));

    await client.post<void>('/auth/register', body: {'role': 'FARMER'});

    expect(adapter.last!.method, 'POST');
    expect(adapter.last!.data, {'role': 'FARMER'});
  });

  test('error response → ApiException with server code', () async {
    respond(
      (_) async => _json({
        'statusCode': 401,
        'code': 'USER_INVALID_CREDENTIALS',
        'message': 'Invalid',
      }, 401),
    );

    await expectLater(
      client.post<void>('/auth/login', body: const <String, Object?>{}),
      throwsA(
        isA<ApiException>()
            .having((e) => e.statusCode, 'statusCode', 401)
            .having((e) => e.code, 'code', 'USER_INVALID_CREDENTIALS'),
      ),
    );
  });

  test('timeout → TIMEOUT', () async {
    respond(
      (o) async => throw DioException(
        requestOptions: o,
        type: DioExceptionType.connectionTimeout,
      ),
    );

    await expectLater(
      client.get<void>('/x'),
      throwsA(isA<ApiException>().having((e) => e.code, 'code', 'TIMEOUT')),
    );
  });

  test('no connection → NETWORK_ERROR', () async {
    respond(
      (o) async => throw DioException(
        requestOptions: o,
        type: DioExceptionType.connectionError,
      ),
    );

    await expectLater(
      client.get<void>('/x'),
      throwsA(
        isA<ApiException>().having((e) => e.code, 'code', 'NETWORK_ERROR'),
      ),
    );
  });

  test('decode type error → INVALID_RESPONSE', () async {
    respond((_) async => _json({'id': 1}, 200));

    await expectLater(
      client.get(
        '/x',
        decode: (json) => (json! as Map<String, Object?>)['id']! as String,
      ),
      throwsA(
        isA<ApiException>()
            .having((e) => e.code, 'code', 'INVALID_RESPONSE')
            .having((e) => e.statusCode, 'statusCode', 200),
      ),
    );
  });
}
