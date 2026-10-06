import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/core/utils/clock.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/resend_code_request.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/features/auth/presentation/controllers/resend_code_controller.dart';
import 'package:ui_ux/shared/controllers/countdown_controller.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

import '../../../../helpers/pump_app.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockHandoffStore extends Mock implements AuthHandoffStore {}

void main() {
  const purpose = OtpPurpose.activateDistributor;
  final now = DateTime(2026, 10, 6, 9);

  late _MockAuthRepository repo;
  late _MockHandoffStore store;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(
      const ResendCodeRequest(identifier: 'x', purpose: purpose),
    );
    registerFallbackValue(
      AuthHandoff(
        loginType: LoginType.email,
        identifier: 'x',
        at: now,
        purpose: purpose,
      ),
    );
  });

  setUp(() {
    repo = _MockAuthRepository();
    store = _MockHandoffStore();
    when(() => store.save(any())).thenAnswer((_) async {});
    container = makeContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        authHandoffStoreProvider.overrideWithValue(store),
        clockProvider.overrideWithValue(() => now),
      ],
    );
  });

  Future<bool> resend() => container
      .read(resendCodeControllerProvider(purpose).notifier)
      .resend(loginType: LoginType.phone, identifier: '0901234567');

  void listenAll() {
    final subs = [
      container.listen(resendCodeControllerProvider(purpose), (_, _) {}),
      container.listen(countdownControllerProvider(purpose.value), (_, _) {}),
    ];
    addTearDown(() {
      for (final s in subs) {
        s.close();
      }
    });
  }

  test(
    'success → handoff saved at now + countdown restarted (3 min)',
    () async {
      when(() => repo.resendCode(any())).thenAnswer((_) async {});
      listenAll();

      expect(await resend(), isTrue);

      verify(
        () => repo.resendCode(
          const ResendCodeRequest(identifier: '0901234567', purpose: purpose),
        ),
      ).called(1);
      verify(
        () => store.save(
          AuthHandoff(
            loginType: LoginType.phone,
            identifier: '0901234567',
            at: now,
            purpose: purpose,
          ),
        ),
      ).called(1);
      expect(
        container.read(countdownControllerProvider(purpose.value)),
        otpResendCooldown,
      );
    },
  );

  test('ApiException → false, no handoff, countdown untouched', () async {
    when(() => repo.resendCode(any())).thenThrow(
      const ApiException(code: 'OTP_NOT_FOUND', message: 'nf', statusCode: 404),
    );
    listenAll();

    expect(await resend(), isFalse);

    expect(
      container.read(resendCodeControllerProvider(purpose)).error,
      isA<ApiException>().having((e) => e.code, 'code', 'OTP_NOT_FOUND'),
    );
    verifyNever(() => store.save(any()));
    expect(
      container.read(countdownControllerProvider(purpose.value)),
      Duration.zero,
    );
  });
}
