import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/core/network/session_events.dart';
import 'package:ui_ux/features/auth/auth.dart';
import 'package:ui_ux/features/auth/data/auth_session_repository.dart';

import '../../../../fixtures/auth_fixtures.dart';
import '../../../../helpers/pump_app.dart';

class _MockSessionRepository extends Mock implements AuthSessionRepository {}

void main() {
  late _MockSessionRepository repo;
  late ProviderContainer container;

  setUpAll(() => registerFallbackValue(tokenPair));

  setUp(() {
    repo = _MockSessionRepository();
    when(() => repo.saveTokens(any())).thenAnswer((_) async {});
    when(() => repo.logout()).thenAnswer((_) async {});
    container = makeContainer(
      overrides: [authSessionRepositoryProvider.overrideWithValue(repo)],
    );
  });

  Future<AuthState> session() => container.read(authStateProvider.future);

  test('no stored session → Guest; derived providers false / null', () async {
    when(() => repo.restore()).thenAnswer((_) async => null);

    expect(await session(), isA<Guest>());
    expect(container.read(isLoggedInProvider), isFalse);
    expect(container.read(currentUserProvider), isNull);
  });

  test('stored session → Authenticated with /users/me user', () async {
    when(() => repo.restore()).thenAnswer((_) async => distributorUser);

    final state = await session();

    expect(state, isA<Authenticated>());
    expect((state as Authenticated).user, distributorUser);
    expect(container.read(isLoggedInProvider), isTrue);
    expect(container.read(currentUserProvider), distributorUser);
  });

  test('while loading → not logged in', () {
    when(() => repo.restore()).thenAnswer((_) => Future.value(farmerUser));
    expect(container.read(isLoggedInProvider), isFalse);
  });

  test('signedIn → tokens saved, Authenticated', () async {
    when(() => repo.restore()).thenAnswer((_) async => null);
    await session();

    await container
        .read(authStateProvider.notifier)
        .signedIn(tokenPair, farmerUser);

    verify(() => repo.saveTokens(tokenPair)).called(1);
    expect(container.read(currentUserProvider), farmerUser);
  });

  test('logout → repository logout, Guest', () async {
    when(() => repo.restore()).thenAnswer((_) async => farmerUser);
    await session();

    await container.read(authStateProvider.notifier).logout();

    verify(() => repo.logout()).called(1);
    expect(container.read(authStateProvider).value, isA<Guest>());
  });

  test('session expired event → Guest', () async {
    when(() => repo.restore()).thenAnswer((_) async => farmerUser);
    await session();

    container.read(sessionEventsProvider).notifyExpired();
    await Future<void>.delayed(Duration.zero);

    expect(container.read(authStateProvider).value, isA<Guest>());
    expect(container.read(isLoggedInProvider), isFalse);
  });
}
