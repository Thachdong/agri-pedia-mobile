import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/network/auth_interceptor.dart';
import 'package:ui_ux/core/storage/token_storage.dart';

/// Answers every request with [handler]; records what was sent.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.handler);

  final Future<ResponseBody> Function(RequestOptions options) handler;
  final sent = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    sent.add(options);
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _json(int status, Object body) => ResponseBody.fromString(
  jsonEncode(body),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

const _old = TokenPair(accessToken: 'old-acc', refreshToken: 'old-ref');
const _fresh = TokenPair(accessToken: 'new-acc', refreshToken: 'new-ref');

void main() {
  late TokenStorage tokens;
  late _FakeAdapter adapter;
  late Dio dio;
  late int refreshCalls;
  late int expiredCalls;

  /// Server accepting only the fresh access token on /data, /auth/login → 401.
  Future<ResponseBody> server(RequestOptions o) async {
    if (o.path == '/auth/login') {
      return _json(401, {'code': 'USER_INVALID_CREDENTIALS'});
    }
    return o.headers['Authorization'] == 'Bearer ${_fresh.accessToken}'
        ? _json(200, {'ok': true})
        : _json(401, {'code': 'AUTH_INVALID_ACCESS_TOKEN'});
  }

  void build({
    required TokenRefresher refresh,
    Future<ResponseBody> Function(RequestOptions)? handler,
  }) {
    adapter = _FakeAdapter(handler ?? server);
    dio = Dio(BaseOptions(baseUrl: 'https://api.test'))
      ..httpClientAdapter = adapter;
    dio.interceptors.add(
      AuthInterceptor(
        tokens: tokens,
        refresh: (refreshToken) {
          refreshCalls++;
          return refresh(refreshToken);
        },
        retry: dio.fetch,
        onSessionExpired: () => expiredCalls++,
      ),
    );
  }

  setUp(() async {
    FlutterSecureStorage.setMockInitialValues({});
    tokens = TokenStorage(const FlutterSecureStorage());
    await tokens.write(_old);
    refreshCalls = 0;
    expiredCalls = 0;
  });

  test('adds Bearer from storage; none for a guest', () async {
    build(refresh: (_) async => _fresh, handler: (_) async => _json(200, {}));

    await dio.get<Object?>('/data');
    expect(adapter.sent.last.headers['Authorization'], 'Bearer old-acc');

    await tokens.clear();
    await dio.get<Object?>('/data');
    expect(adapter.sent.last.headers.containsKey('Authorization'), isFalse);
  });

  test('401 → refresh with refresh token, save pair, retry once', () async {
    String? sentRefresh;
    build(
      refresh: (refreshToken) async {
        sentRefresh = refreshToken;
        return _fresh;
      },
    );

    final response = await dio.get<Object?>('/data');

    expect(response.statusCode, 200);
    expect(sentRefresh, 'old-ref');
    expect(refreshCalls, 1);
    expect(adapter.sent, hasLength(2));
    expect((await tokens.read())?.accessToken, 'new-acc');
    expect((await tokens.read())?.refreshToken, 'new-ref');
    expect(expiredCalls, 0);
  });

  test('concurrent 401s share one refresh, all retried', () async {
    final gate = Completer<TokenPair?>();
    build(refresh: (_) => gate.future);

    final calls = [for (var i = 0; i < 3; i++) dio.get<Object?>('/data')];
    await Future<void>.delayed(Duration.zero);
    gate.complete(_fresh);
    final responses = await Future.wait(calls);

    expect(responses.map((r) => r.statusCode), everyElement(200));
    expect(refreshCalls, 1);
  });

  test(
    'a 401 for a token already replaced → retried without refresh',
    () async {
      build(refresh: (_) async => _fresh);
      // Another call refreshed meanwhile: storage holds the fresh pair but this
      // request went out with the old token.
      final options = RequestOptions(
        path: '/data',
        baseUrl: 'https://api.test',
        headers: {'Authorization': 'Bearer old-acc'},
      );
      await tokens.write(_fresh);

      final interceptor = dio.interceptors.whereType<AuthInterceptor>().single;
      final handler = _CapturingErrorHandler();
      await interceptor.onError(
        DioException(
          requestOptions: options,
          response: Response<Object?>(requestOptions: options, statusCode: 401),
        ),
        handler,
      );

      expect(handler.resolved?.statusCode, 200);
      expect(refreshCalls, 0);
    },
  );

  test(
    'refresh rejected → tokens cleared, session expired, 401 surfaces',
    () async {
      build(refresh: (_) async => null);

      await expectLater(
        dio.get<Object?>('/data'),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'status',
            401,
          ),
        ),
      );
      expect(refreshCalls, 1);
      expect(expiredCalls, 1);
      expect(await tokens.read(), isNull);
    },
  );

  test('transient refresh failure → tokens kept, not expired', () async {
    build(refresh: (_) async => throw Exception('offline'));

    await expectLater(dio.get<Object?>('/data'), throwsA(isA<DioException>()));
    expect(expiredCalls, 0);
    expect((await tokens.read())?.accessToken, 'old-acc');
  });

  test('retried request 401 again → no second refresh, no loop', () async {
    // Server rejects even the fresh token.
    build(
      refresh: (_) async => _fresh,
      handler: (_) async => _json(401, {'code': 'AUTH_INVALID_ACCESS_TOKEN'}),
    );

    await expectLater(dio.get<Object?>('/data'), throwsA(isA<DioException>()));
    expect(refreshCalls, 1);
    expect(adapter.sent, hasLength(2));
  });

  test('401 from /auth/login or a guest request → no refresh', () async {
    build(refresh: (_) async => _fresh);

    await expectLater(
      dio.post<Object?>('/auth/login', data: {}),
      throwsA(isA<DioException>()),
    );
    await tokens.clear();
    await expectLater(dio.get<Object?>('/data'), throwsA(isA<DioException>()));
    expect(refreshCalls, 0);
  });

  group('refreshTokensWith', () {
    Dio bare(Future<ResponseBody> Function(RequestOptions) handler) =>
        Dio(BaseOptions(baseUrl: 'https://api.test'))
          ..httpClientAdapter = _FakeAdapter(handler);

    test('200 → new pair; body {refreshToken}', () async {
      RequestOptions? sent;
      final refresh = refreshTokensWith(
        bare((o) async {
          sent = o;
          return _json(200, {'accessToken': 'a2', 'refreshToken': 'r2'});
        }),
      );

      final pair = await refresh('r1');

      expect(pair?.accessToken, 'a2');
      expect(pair?.refreshToken, 'r2');
      expect(sent?.path, '/auth/refresh-token');
      expect(sent?.data, {'refreshToken': 'r1'});
    });

    test('401 / 400 → null (session over)', () async {
      for (final status in [401, 400]) {
        final refresh = refreshTokensWith(
          bare((_) async => _json(status, {'code': 'X'})),
        );
        expect(await refresh('r1'), isNull, reason: '$status');
      }
    });

    test('500 → throws (keep session)', () async {
      final refresh = refreshTokensWith(
        bare((_) async => _json(500, {'code': 'X'})),
      );
      await expectLater(refresh('r1'), throwsA(isA<DioException>()));
    });
  });
}

class _CapturingErrorHandler extends ErrorInterceptorHandler {
  Response<dynamic>? resolved;

  @override
  void resolve(Response<dynamic> response) => resolved = response;

  @override
  void next(DioException err) {}
}
