import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/confirm_password_reset_request.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/features/auth/presentation/controllers/auth_handoff_provider.dart';
import 'package:ui_ux/features/auth/presentation/controllers/confirm_password_reset_controller.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

import '../../../../helpers/pump_app.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockHandoffStore extends Mock implements AuthHandoffStore {}

void main() {
  const request = ConfirmPasswordResetRequest(
    identifier: 'farmer@example.com',
    code: '123456',
    newPassword: 'secret123',
  );
  const purpose = OtpPurpose.resetPassword;
  final handoff = AuthHandoff(
    loginType: LoginType.email,
    identifier: 'farmer@example.com',
    at: DateTime(2026, 10, 6, 9),
    purpose: purpose,
  );

  late _MockAuthRepository repo;
  late _MockHandoffStore store;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(request);
    registerFallbackValue(purpose);
  });

  setUp(() {
    repo = _MockAuthRepository();
    store = _MockHandoffStore();
    var saved = handoff as AuthHandoff?;
    when(() => store.read(purpose)).thenAnswer((_) async => saved);
    when(() => store.clear(purpose)).thenAnswer((_) async => saved = null);
    container = makeContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        authHandoffStoreProvider.overrideWithValue(store),
      ],
    );
  });

  ConfirmPasswordResetController notifier() =>
      container.read(confirmPasswordResetControllerProvider.notifier);

  void keepAlive() {
    final sub = container.listen(
      confirmPasswordResetControllerProvider,
      (_, _) {},
    );
    addTearDown(sub.close);
  }

  test('success → true, handoff cleared, handoff provider refreshed', () async {
    when(() => repo.confirmPasswordReset(any())).thenAnswer((_) async {});
    keepAlive();
    final handoffSub = container.listen(
      authHandoffProvider(purpose),
      (_, _) {},
    );
    addTearDown(handoffSub.close);
    expect(await container.read(authHandoffProvider(purpose).future), handoff);

    expect(await notifier().submit(request), isTrue);

    verify(() => repo.confirmPasswordReset(request)).called(1);
    verify(() => store.clear(purpose)).called(1);
    expect(
      container.read(confirmPasswordResetControllerProvider).hasError,
      isFalse,
    );
    expect(await container.read(authHandoffProvider(purpose).future), isNull);
  });

  test('ApiException → false, AsyncError with code, handoff kept', () async {
    when(() => repo.confirmPasswordReset(any())).thenThrow(
      const ApiException(
        code: 'OTP_EXPIRED',
        message: 'expired',
        statusCode: 422,
      ),
    );
    keepAlive();

    expect(await notifier().submit(request), isFalse);

    expect(
      container.read(confirmPasswordResetControllerProvider).error,
      isA<ApiException>().having((e) => e.code, 'code', 'OTP_EXPIRED'),
    );
    verifyNever(() => store.clear(any()));
  });
}
