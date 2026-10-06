import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Debug-only request log: method, URL, status, duration and the request
/// body with secrets masked. Headers (Bearer token) and response bodies
/// (login / refresh return tokens) are never printed.
class DebugLogInterceptor extends Interceptor {
  DebugLogInterceptor({void Function(String line)? log})
    : _log = log ?? debugPrint;

  static const _startKey = 'debugLog.start';

  final void Function(String line) _log;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startKey] = DateTime.now();
    final body = options.data == null
        ? ''
        : ' ${redactSensitive(options.data)}';
    _log('→ ${options.method} ${options.uri}$body');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _log(
      '← ${response.statusCode} ${response.requestOptions.method} '
      '${response.requestOptions.uri} ${_elapsed(response.requestOptions)}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    final code = response?.data is Map ? (response!.data as Map)['code'] : null;
    _log(
      '✕ ${response?.statusCode ?? err.type.name} '
      '${err.requestOptions.method} ${err.requestOptions.uri} '
      '${code ?? ''} ${_elapsed(err.requestOptions)}',
    );
    handler.next(err);
  }

  static String _elapsed(RequestOptions options) {
    final start = options.extra[_startKey];
    return start is DateTime
        ? '${DateTime.now().difference(start).inMilliseconds}ms'
        : '';
  }
}

/// Request body keys whose values are never logged (openapi field names).
const sensitiveKeys = {
  'password',
  'oldPassword',
  'newPassword',
  'accessToken',
  'refreshToken',
  'code',
  'ticket',
};

/// Copy of [data] with [sensitiveKeys] values replaced by `***`, at any
/// depth. Non-JSON bodies (FormData, streams) are not printed.
@visibleForTesting
Object? redactSensitive(Object? data) => switch (data) {
  final Map<Object?, Object?> map => {
    for (final e in map.entries)
      e.key: sensitiveKeys.contains(e.key) ? '***' : redactSensitive(e.value),
  },
  final List<Object?> list => [for (final item in list) redactSensitive(item)],
  String() || num() || bool() || null => data,
  _ => '<${data.runtimeType}>',
};
