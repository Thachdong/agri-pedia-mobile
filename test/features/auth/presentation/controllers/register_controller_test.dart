import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/core/utils/clock.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/features/auth/presentation/controllers/register_controller.dart';
import 'package:ui_ux/shared/enums/login_type.dart';

import '../../../../fixtures/auth_fixtures.dart';
import '../../../../helpers/pump_app.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockHandoffStore extends Mock implements AuthHandoffStore {}

void main() {
  late _MockAuthRepository repo;
  late _MockHandoffStore store;
  late ProviderContainer container;
  final now = DateTime(2026, 10, 6, 9, 30);

  setUpAll(() {
    registerFallbackValue(farmerRequest);
    registerFallbackValue(
      AuthHandoff(
        loginType: LoginType.email,
        identifier: 'x',
        at: now,
        purpose: OtpPurpose.activateDistributor,
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

  RegisterController notifier() =>
      container.read(registerControllerProvider.notifier);

  test('FARMER success → canLogin, no handoff', () async {
    when(() => repo.register(any())).thenAnswer((_) async {});
    final sub = container.listen(registerControllerProvider, (_, _) {});
    addTearDown(sub.close);

    expect(await notifier().submit(farmerRequest), RegisterOutcome.canLogin);

    expect(
      container.read(registerControllerProvider).value,
      RegisterOutcome.canLogin,
    );
    verify(() => repo.register(farmerRequest)).called(1);
    verifyNever(() => store.save(any()));
  });

  test('DISTRIBUTOR success → needsActivation + handoff at = clock', () async {
    when(() => repo.register(any())).thenAnswer((_) async {});
    final sub = container.listen(registerControllerProvider, (_, _) {});
    addTearDown(sub.close);

    expect(
      await notifier().submit(distributorRequest),
      RegisterOutcome.needsActivation,
    );

    verify(
      () => store.save(
        AuthHandoff(
          loginType: LoginType.phone,
          identifier: '0901234567',
          at: now,
          purpose: OtpPurpose.activateDistributor,
        ),
      ),
    ).called(1);
  });

  test('server error → null, AsyncError with the code, no handoff', () async {
    when(() => repo.register(any())).thenThrow(
      const ApiException(
        statusCode: 409,
        code: 'USER_IDENTIFIER_ALREADY_USED',
        message: 'used',
      ),
    );
    final sub = container.listen(registerControllerProvider, (_, _) {});
    addTearDown(sub.close);

    expect(await notifier().submit(distributorRequest), isNull);

    final state = container.read(registerControllerProvider);
    expect(
      state.error,
      isA<ApiException>().having(
        (e) => e.code,
        'code',
        'USER_IDENTIFIER_ALREADY_USED',
      ),
    );
    verifyNever(() => store.save(any()));
  });

  test('handoff save fails → error, not needsActivation', () async {
    when(() => repo.register(any())).thenAnswer((_) async {});
    when(() => store.save(any())).thenThrow(StateError('disk full'));
    final sub = container.listen(registerControllerProvider, (_, _) {});
    addTearDown(sub.close);

    expect(await notifier().submit(distributorRequest), isNull);
    expect(container.read(registerControllerProvider).hasError, isTrue);
  });

  test('controller disposed mid-request → handoff still saved', () async {
    final pending = Completer<void>();
    when(() => repo.register(any())).thenAnswer((_) => pending.future);
    final sub = container.listen(registerControllerProvider, (_, _) {});

    final future = notifier().submit(distributorRequest);
    sub.close(); // auto-dispose: nobody listens anymore
    await Future<void>.delayed(Duration.zero);
    pending.complete();

    expect(await future, RegisterOutcome.needsActivation);
    verify(() => store.save(any())).called(1);
  });

  test('loading while the request is in flight', () async {
    when(() => repo.register(any())).thenAnswer((_) async {});
    final sub = container.listen(registerControllerProvider, (_, _) {});
    addTearDown(sub.close);

    final future = notifier().submit(farmerRequest);
    expect(container.read(registerControllerProvider).isLoading, isTrue);
    await future;
    expect(container.read(registerControllerProvider).isLoading, isFalse);
  });
}
