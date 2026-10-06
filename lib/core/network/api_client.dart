import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/config/env.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/core/network/auth_interceptor.dart';
import 'package:ui_ux/core/network/debug_log_interceptor.dart';
import 'package:ui_ux/core/network/session_events.dart';
import 'package:ui_ux/core/storage/token_storage.dart';

part 'api_client.g.dart';

/// Turns a decoded JSON body into a typed value.
typedef JsonDecode<T> = T Function(Object? json);

/// The only HTTP entry point for features. Wraps dio so no other layer
/// imports it; every failure is rethrown as [ApiException].
class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<T> get<T>(
    String path, {
    Map<String, Object?>? query,
    JsonDecode<T>? decode,
  }) => _send(
    () => _dio.get<Object?>(path, queryParameters: _withoutNulls(query)),
    decode,
  );

  Future<T> post<T>(
    String path, {
    Object? body,
    Map<String, Object?>? query,
    JsonDecode<T>? decode,
  }) => _send(
    () => _dio.post<Object?>(
      path,
      data: body,
      queryParameters: _withoutNulls(query),
    ),
    decode,
  );

  Future<T> patch<T>(
    String path, {
    Object? body,
    Map<String, Object?>? query,
    JsonDecode<T>? decode,
  }) => _send(
    () => _dio.patch<Object?>(
      path,
      data: body,
      queryParameters: _withoutNulls(query),
    ),
    decode,
  );

  Future<T> delete<T>(
    String path, {
    Object? body,
    Map<String, Object?>? query,
    JsonDecode<T>? decode,
  }) => _send(
    () => _dio.delete<Object?>(
      path,
      data: body,
      queryParameters: _withoutNulls(query),
    ),
    decode,
  );

  Future<T> _send<T>(
    Future<Response<Object?>> Function() request,
    JsonDecode<T>? decode,
  ) async {
    final Response<Object?> response;
    try {
      response = await request();
    } on DioException catch (e) {
      throw _fromDio(e);
    }
    try {
      return decode != null ? decode(response.data) : response.data as T;
    } on TypeError catch (e) {
      throw ApiException(
        statusCode: response.statusCode,
        code: ApiException.invalidResponse,
        message: e.toString(),
      );
    } on FormatException catch (e) {
      throw ApiException(
        statusCode: response.statusCode,
        code: ApiException.invalidResponse,
        message: e.message,
      );
    }
  }

  static Map<String, Object?>? _withoutNulls(Map<String, Object?>? query) =>
      query == null
      ? null
      : {
          for (final e in query.entries)
            if (e.value != null) e.key: e.value,
        };

  static ApiException _fromDio(DioException e) {
    final response = e.response;
    if (response != null) {
      return ApiException.fromBody(
        response.data,
        statusCode: response.statusCode,
      );
    }
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => ApiException(
        code: ApiException.timeout,
        message: e.message ?? 'Request timed out',
      ),
      DioExceptionType.cancel => ApiException(
        code: ApiException.cancelled,
        message: e.message ?? 'Request cancelled',
      ),
      DioExceptionType.connectionError => ApiException(
        code: ApiException.networkError,
        message: e.message ?? 'Network error',
      ),
      _ => ApiException(
        code: ApiException.unknown,
        message: e.message ?? e.error.toString(),
      ),
    };
  }
}

/// Configured dio instance with the auth interceptor. Token refresh goes
/// through a second bare dio so it never re-enters [AuthInterceptor].
@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) {
  final options = BaseOptions(
    baseUrl: Env.apiUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );
  final dio = Dio(options);
  final refreshDio = Dio(options);
  dio.interceptors.add(
    AuthInterceptor(
      tokens: ref.watch(tokenStorageProvider),
      refresh: refreshTokensWith(refreshDio),
      retry: dio.fetch,
      onSessionExpired: ref.watch(sessionEventsProvider).notifyExpired,
    ),
  );
  if (kDebugMode) {
    dio.interceptors.add(DebugLogInterceptor());
    refreshDio.interceptors.add(DebugLogInterceptor());
  }
  ref.onDispose(() {
    dio.close();
    refreshDio.close();
  });
  return dio;
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) => ApiClient(ref.watch(dioClientProvider));
