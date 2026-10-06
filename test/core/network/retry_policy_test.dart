import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/core/network/retry_policy.dart';

ApiException _e(String code, [int? status]) =>
    ApiException(code: code, message: '', statusCode: status);

void main() {
  test('transient errors retry with backoff, at most twice', () {
    final timeout = _e(ApiException.timeout);
    expect(providerRetry(0, timeout), const Duration(milliseconds: 500));
    expect(providerRetry(1, timeout), const Duration(seconds: 1));
    expect(providerRetry(2, timeout), isNull);
    expect(
      providerRetry(0, _e(ApiException.networkError)),
      const Duration(milliseconds: 500),
    );
  });

  test('server answers and other errors never retry', () {
    expect(providerRetry(0, _e('REVIEW_DISTRIBUTOR_NOT_FOUND', 404)), isNull);
    expect(providerRetry(0, _e(ApiException.unknown, 500)), isNull);
    expect(providerRetry(0, _e(ApiException.invalidResponse, 200)), isNull);
    expect(providerRetry(0, StateError('bug')), isNull);
  });

  // testWidgets runs in fake time: tester.pump advances retry timers.
  /// Watches a provider that always throws [error]; counts runs in [calls].
  void watchFailing(ApiException error, List<int> calls) {
    final provider = FutureProvider<int>((ref) async {
      calls[0]++;
      throw error;
    });
    final container = ProviderContainer(retry: providerRetry);
    addTearDown(container.dispose);
    container.listen(provider, (_, _) {}, onError: (_, _) {});
  }

  testWidgets('a 404 provider runs once', (tester) async {
    final calls = [0];
    watchFailing(_e('PRODUCT_NOT_FOUND', 404), calls);
    await tester.pump(const Duration(seconds: 5));
    expect(calls[0], 1);
  });

  testWidgets('a timeout provider runs 1 + 2 retries', (tester) async {
    final calls = [0];
    watchFailing(_e(ApiException.timeout), calls);
    await tester.pump(const Duration(seconds: 5));
    await tester.pump(const Duration(seconds: 5));
    expect(calls[0], 3);
  });
}
