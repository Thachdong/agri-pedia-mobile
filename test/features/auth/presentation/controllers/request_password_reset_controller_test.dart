import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/core/utils/clock.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/request_password_reset_request.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/features/auth/presentation/controllers/auth_handoff_provider.dart';
import 'package:ui_ux/features/auth/presentation/controllers/request_password_reset_controller.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

import '../../../../helpers/pump_app.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockHandoffStore extends Mock implements AuthHandoffStore {}

void main() {
  const request = RequestPasswordResetRequest(
    loginType: LoginType.email,
    identifier: 'farmer@example.com',
  );
  const purpose = OtpPurpose.resetPassword;
  final now = DateTime(2026, 10, 6, 9);

  late _MockAuthRepository repo;
  late _MockHandoffStore store;
  late ProviderContainer container;

  AuthHandoff handoffAt(DateTime at) => AuthHandoff(
    loginType: LoginType.email,
    identifier: 'farmer@example.com',
    at: at,
    purpose: purpose,
  );

  setUpAll(() {
    registerFallbackValue(request);
    registerFallbackValue(handoffAt(now));
  });

  setUp(() {
    repo = _MockAuthRepository();
    store = _MockHandoffStore();
    AuthHandoff? saved;
    when(() => store.read(purpose)).thenAnswer((_) async => saved);
    when(() => store.save(any())).thenAnswer(
      (call) async => saved = call.positionalArguments.single as AuthHandoff,
    );
    container = makeContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        authHandoffStoreProvider.overrideWithValue(store),
        clockProvider.overrideWithValue(() => now),
      ],
    );
  });

  RequestPasswordResetController notifier() =>
      container.read(requestPasswordResetControllerProvider.notifier);

  void keepAlive() {
    final sub = container.listen(
      requestPasswordResetControllerProvider,
      (_, _) {},
    );
    addTearDown(sub.close);
  }

  test(
    'code sent → true, handoff at = now, handoff provider refreshed',
    () async {
      when(
        () => repo.requestPasswordReset(any()),
      ).thenAnswer((_) async => null);
      keepAlive();
      final handoffSub = container.listen(
        authHandoffProvider(purpose),
        (_, _) {},
      );
      addTearDown(handoffSub.close);
      expect(await container.read(authHandoffProvider(purpose).future), isNull);

      expect(await notifier().submit(request), isTrue);

      verify(() => repo.requestPasswordReset(request)).called(1);
      verify(() => store.save(handoffAt(now))).called(1);
      expect(
        container.read(requestPasswordResetControllerProvider).hasError,
        isFalse,
      );
      expect(
        await container.read(authHandoffProvider(purpose).future),
        handoffAt(now),
      );
    },
  );

  test('previous code still valid → handoff at = issuedAt', () async {
    final issuedAt = DateTime.utc(2026, 10, 6, 1, 58);
    when(
      () => repo.requestPasswordReset(any()),
    ).thenAnswer((_) async => issuedAt);
    keepAlive();

    expect(await notifier().submit(request), isTrue);

    verify(() => store.save(handoffAt(issuedAt))).called(1);
  });

  test('ApiException → false, AsyncError with code, no handoff', () async {
    when(() => repo.requestPasswordReset(any())).thenThrow(
      const ApiException(
        code: 'OTP_ACCOUNT_NOT_FOUND',
        message: 'nf',
        statusCode: 404,
      ),
    );
    keepAlive();

    expect(await notifier().submit(request), isFalse);

    expect(
      container.read(requestPasswordResetControllerProvider).error,
      isA<ApiException>().having(
        (e) => e.code,
        'code',
        'OTP_ACCOUNT_NOT_FOUND',
      ),
    );
    verifyNever(() => store.save(any()));
  });
}
