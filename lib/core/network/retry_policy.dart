import 'package:ui_ux/core/network/api_exception.dart';

/// Riverpod's automatic retry for failed providers (`ProviderScope.retry`).
///
/// Only transient failures (no connection, timeout) are retried, at most
/// [maxRetries] times with backoff 500ms, 1s. Server answers (4xx/5xx,
/// domain codes) fail at once so the UI shows the error and its retry button.
const maxRetries = 2;

Duration? providerRetry(int retryCount, Object error) {
  if (retryCount >= maxRetries) return null;
  final transient =
      error is ApiException &&
      (error.code == ApiException.networkError ||
          error.code == ApiException.timeout);
  if (!transient) return null;
  return Duration(milliseconds: 500 * (1 << retryCount));
}
