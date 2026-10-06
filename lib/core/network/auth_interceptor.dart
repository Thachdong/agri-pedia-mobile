import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ui_ux/core/storage/token_storage.dart';

/// Exchanges a refresh token for a new pair. Returns null when the server
/// rejects the token (session over); throws on transient failures (network,
/// 5xx) so the session is kept.
typedef TokenRefresher = Future<TokenPair?> Function(String refreshToken);

/// Re-sends a request (normally `dio.fetch`, so it passes the interceptors
/// again).
typedef RequestRetrier = Future<Response<dynamic>> Function(RequestOptions);

/// Adds `Authorization: Bearer <access>` and recovers from an expired access
/// token (CLAUDE.md decision 3):
/// - on 401 the token pair is refreshed once — concurrent 401s share the
///   same in-flight refresh — then the request is retried once;
/// - a request that failed with a token another call already replaced is
///   just retried with the current one;
/// - refresh rejected → tokens cleared + [onSessionExpired].
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this._tokens,
    required this._refresh,
    required this._retry,
    required this._onSessionExpired,
  });

  static const refreshPath = '/auth/refresh-token';
  static const _loginPath = '/auth/login';
  static const _retriedKey = 'auth.retried';
  static const _header = 'Authorization';

  final TokenStorage _tokens;
  final TokenRefresher _refresh;
  final RequestRetrier _retry;
  final void Function() _onSessionExpired;

  Completer<TokenPair?>? _refreshing;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_is(options, refreshPath)) {
      try {
        final pair = await _tokens.read();
        if (pair != null) options.headers[_header] = _bearer(pair);
      } on Object {
        // Unreadable storage: send as guest.
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final sent = options.headers[_header];
    if (err.response?.statusCode != 401 ||
        sent is! String ||
        options.extra[_retriedKey] == true ||
        _is(options, refreshPath) ||
        _is(options, _loginPath)) {
      return handler.next(err);
    }

    final TokenPair? fresh;
    try {
      final current = await _tokens.read();
      if (current == null) return handler.next(err);
      fresh = _bearer(current) != sent
          ? current
          : await _refreshOnce(current.refreshToken);
    } on Object {
      // Transient refresh failure: keep the session, surface the 401.
      return handler.next(err);
    }
    if (fresh == null) return handler.next(err);

    try {
      final response = await _retry(
        options.copyWith(
          headers: {...options.headers, _header: _bearer(fresh)},
          extra: {...options.extra, _retriedKey: true},
        ),
      );
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  /// Single flight: the first caller refreshes, the others await it.
  Future<TokenPair?> _refreshOnce(String refreshToken) {
    final inFlight = _refreshing;
    if (inFlight != null) return inFlight.future;
    final completer = _refreshing = Completer<TokenPair?>();
    unawaited(() async {
      try {
        final pair = await _refresh(refreshToken);
        if (pair == null) {
          await _tokens.clear();
          _onSessionExpired();
        } else {
          await _tokens.write(pair);
        }
        completer.complete(pair);
      } on Object catch (e, s) {
        completer.completeError(e, s);
      } finally {
        _refreshing = null;
      }
    }());
    return completer.future;
  }

  static bool _is(RequestOptions options, String path) =>
      options.uri.path.endsWith(path);

  static String _bearer(TokenPair pair) => 'Bearer ${pair.accessToken}';
}

/// [TokenRefresher] calling POST /auth/refresh-token on [dio], which must
/// not carry an [AuthInterceptor] (no refresh loop). 400/401
/// (USER_INVALID_REFRESH_TOKEN) → null; anything else rethrows.
TokenRefresher refreshTokensWith(Dio dio) => (refreshToken) async {
  try {
    final response = await dio.post<Map<String, Object?>>(
      AuthInterceptor.refreshPath,
      data: {'refreshToken': refreshToken},
    );
    final body = response.data!;
    return TokenPair(
      accessToken: body['accessToken']! as String,
      refreshToken: body['refreshToken']! as String,
    );
  } on DioException catch (e) {
    final status = e.response?.statusCode;
    if (status == 400 || status == 401) return null;
    rethrow;
  }
};
