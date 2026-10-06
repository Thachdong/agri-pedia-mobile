import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/auth.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/auth_session_repository.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/features/auth/presentation/controllers/login_controller.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

import '../../../../fixtures/auth_fixtures.dart';
import '../../../../helpers/pump_app.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockHandoffStore extends Mock implements AuthHandoffStore {}

class _MockSessionRepository extends Mock implements AuthSessionRepository {}

void main() {
  late _MockAuthRepository repo;
  late _MockHandoffStore store;
  late _MockSessionRepository session;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(loginRequest);
    registerFallbackValue(tokenPair);
    registerFallbackValue(
      AuthHandoff(
        loginType: LoginType.email,
        identifier: 'x',
        at: DateTime(2026),
        purpose: OtpPurpose.activateDistributor,
      ),
    );
  });

  setUp(() {
    repo = _MockAuthRepository();
    store = _MockHandoffStore();
    session = _MockSessionRepository();
    when(() => store.clearLogin()).thenAnswer((_) async {});
    when(() => store.save(any())).thenAnswer((_) async {});
    when(() => session.restore()).thenAnswer((_) async => null);
    when(() => session.saveTokens(any())).thenAnswer((_) async {});
    container = makeContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        authHandoffStoreProvider.overrideWithValue(store),
        authSessionRepositoryProvider.overrideWithValue(session),
      ],
    );
  });

  LoginController notifier() =>
      container.read(loginControllerProvider.notifier);

  void keepAlive() {
    final sub = container.listen(loginControllerProvider, (_, _) {});
    addTearDown(sub.close);
  }

  void loginFails(String code, int status) => when(
    () => repo.login(any()),
  ).thenThrow(ApiException(code: code, message: code, statusCode: status));

  test(
    'success → true, tokens saved, Authenticated, login handoff cleared',
    () async {
      keepAlive();
      await container.read(authStateProvider.future);
      when(
        () => repo.login(any()),
      ).thenAnswer((_) async => (tokens: tokenPair, user: farmerUser));

      expect(await notifier().submit(loginRequest), isTrue);

      verify(() => repo.login(loginRequest)).called(1);
      verify(() => session.saveTokens(tokenPair)).called(1);
      verify(() => store.clearLogin()).called(1);
      expect(container.read(currentUserProvider), farmerUser);
      expect(container.read(loginControllerProvider).hasError, isFalse);
    },
  );

  test(
    'USER_NOT_ACTIVE → false, activate handoff saved with at = epoch',
    () async {
      keepAlive();
      loginFails('USER_NOT_ACTIVE', 403);

      expect(await notifier().submit(loginRequest), isFalse);

      verify(
        () => store.save(
          AuthHandoff(
            loginType: LoginType.email,
            identifier: 'farmer@example.com',
            at: DateTime.fromMillisecondsSinceEpoch(0),
            purpose: OtpPurpose.activateDistributor,
          ),
        ),
      ).called(1);
      expect(
        container.read(loginControllerProvider).error,
        isA<ApiException>().having((e) => e.code, 'code', 'USER_NOT_ACTIVE'),
      );
      verifyNever(() => session.saveTokens(any()));
    },
  );

  test('USER_INVALID_CREDENTIALS → false, nothing saved', () async {
    keepAlive();
    loginFails('USER_INVALID_CREDENTIALS', 401);

    expect(await notifier().submit(loginRequest), isFalse);

    verifyNever(() => store.save(any()));
    verifyNever(() => store.clearLogin());
    verifyNever(() => session.saveTokens(any()));
    expect(container.read(isLoggedInProvider), isFalse);
  });

  test('loading while the request is in flight', () async {
    keepAlive();
    final pending = Completer<void>();
    when(() => repo.login(any())).thenAnswer((_) async {
      await pending.future;
      return (tokens: tokenPair, user: farmerUser);
    });

    final submit = notifier().submit(loginRequest);
    expect(container.read(loginControllerProvider).isLoading, isTrue);
    pending.complete();
    expect(await submit, isTrue);
  });
}
