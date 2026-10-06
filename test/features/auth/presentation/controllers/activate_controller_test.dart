import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/activate_request.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/login_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/features/auth/presentation/controllers/activate_controller.dart';
import 'package:ui_ux/features/auth/presentation/controllers/auth_handoff_provider.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

import '../../../../helpers/pump_app.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockHandoffStore extends Mock implements AuthHandoffStore {}

void main() {
  const request = ActivateRequest(
    identifier: 'npp@example.com',
    code: '123456',
  );
  const purpose = OtpPurpose.activateDistributor;
  final handoff = AuthHandoff(
    loginType: LoginType.email,
    identifier: 'npp@example.com',
    at: DateTime(2026, 10, 6, 9),
    purpose: purpose,
  );

  late _MockAuthRepository repo;
  late _MockHandoffStore store;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(
      const LoginHandoff(loginType: LoginType.email, identifier: 'x'),
    );
    registerFallbackValue(request);
    registerFallbackValue(purpose);
  });

  setUp(() {
    repo = _MockAuthRepository();
    store = _MockHandoffStore();
    when(() => store.saveLogin(any())).thenAnswer((_) async {});
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

  ActivateController notifier() =>
      container.read(activateControllerProvider.notifier);

  test('success → true, handoff cleared, handoff provider refreshed', () async {
    when(() => repo.activate(any())).thenAnswer((_) async {});
    final controllerSub = container.listen(
      activateControllerProvider,
      (_, _) {},
    );
    final handoffSub = container.listen(
      authHandoffProvider(purpose),
      (_, _) {},
    );
    addTearDown(controllerSub.close);
    addTearDown(handoffSub.close);
    expect(await container.read(authHandoffProvider(purpose).future), handoff);

    expect(
      await notifier().submit(request, loginType: LoginType.email),
      isTrue,
    );

    verify(() => repo.activate(request)).called(1);
    verify(() => store.clear(purpose)).called(1);
    expect(container.read(activateControllerProvider).hasError, isFalse);
    expect(await container.read(authHandoffProvider(purpose).future), isNull);
  });

  test('ApiException → false, AsyncError with code, handoff kept', () async {
    when(() => repo.activate(any())).thenThrow(
      const ApiException(
        code: 'OTP_INVALID_CODE',
        message: 'wrong',
        statusCode: 400,
      ),
    );
    final sub = container.listen(activateControllerProvider, (_, _) {});
    addTearDown(sub.close);

    expect(
      await notifier().submit(request, loginType: LoginType.email),
      isFalse,
    );

    final state = container.read(activateControllerProvider);
    expect(
      state.error,
      isA<ApiException>().having((e) => e.code, 'code', 'OTP_INVALID_CODE'),
    );
    verifyNever(() => store.clear(any()));
  });
}
