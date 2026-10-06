import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/app/router/app_router.dart';
import 'package:ui_ux/core/router/routes.dart';
import 'package:ui_ux/core/utils/clock.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/register_request.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/shared/enums/business_type.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/enums/user_role.dart';
import 'package:ui_ux/shared/theme/app_theme.dart';

import '../../../../fixtures/auth_fixtures.dart';
import '../../../../helpers/pump_app.dart';
import '../../../../helpers/register_form_driver.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockHandoffStore extends Mock implements AuthHandoffStore {}

void main() {
  late _MockAuthRepository repo;
  late _MockHandoffStore store;
  late ProviderContainer container;
  final now = DateTime(2026, 10, 6, 9);

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

  /// Real app router, starting at /auth/register.
  Future<void> pumpRegisterRoute(WidgetTester tester) async {
    useTallView(tester);
    repo = _MockAuthRepository();
    store = _MockHandoffStore();
    when(() => repo.register(any())).thenAnswer((_) async {});
    when(() => store.save(any())).thenAnswer((_) async {});
    when(
      () => store.read(OtpPurpose.activateDistributor),
    ).thenAnswer((_) async => null);
    container = makeContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        authHandoffStoreProvider.overrideWithValue(store),
        clockProvider.overrideWithValue(() => now),
        ...locationOverrides,
      ],
    );
    final router = container.read(appRouterProvider)..go(Routes.register);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(theme: buildAppTheme(), routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('sections: header, title, tabs, footer links', (tester) async {
    await pumpRegisterRoute(tester);

    expect(find.text('AgriPedia'), findsOneWidget);
    expect(find.text('Back To Home'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.text('PHONE'), findsOneWidget);
    expect(find.text('Đăng ký'), findsOneWidget);
    expect(find.text('Đăng nhập'), findsOneWidget);
    expect(find.text('Reset mật khẩu'), findsOneWidget);
  });

  testWidgets('identifier is focused on open', (tester) async {
    await pumpRegisterRoute(tester);

    final identifier = tester.widget<EditableText>(
      find.byType(EditableText).first,
    );
    expect(identifier.focusNode.hasFocus, isTrue);
  });

  testWidgets('DISTRIBUTOR success → handoff saved, /auth/activate', (
    tester,
  ) async {
    await pumpRegisterRoute(tester);
    await fillRegisterForm(tester, distributor: true);

    await tapRegister(tester);
    await tester.pumpAndSettle();

    final request =
        verify(() => repo.register(captureAny())).captured.single
            as RegisterRequest;
    expect(request.role, UserRole.distributor);
    expect(request.bussinessType, BusinessType.seedsSeedlings);
    expect(request.address.ward, 'phuong_ba_dinh');
    verify(
      () => store.save(
        AuthHandoff(
          loginType: LoginType.email,
          identifier: 'npp@example.com',
          at: now,
          purpose: OtpPurpose.activateDistributor,
        ),
      ),
    ).called(1);
    expect(find.text('Activate Account'), findsOneWidget);
  });

  testWidgets('FARMER success → no handoff, /auth/login', (tester) async {
    await pumpRegisterRoute(tester);
    await fillRegisterForm(tester, identifier: 'farmer@example.com');

    await tapRegister(tester);
    await tester.pumpAndSettle();

    verifyNever(() => store.save(any()));
    expect(find.text('Đăng nhập'), findsWidgets);
    expect(
      container.read(appRouterProvider).state.matchedLocation,
      Routes.login,
    );
  });

  testWidgets('Back To Home → /', (tester) async {
    await pumpRegisterRoute(tester);

    await tester.tap(find.text('Back To Home'));
    await tester.pumpAndSettle();

    expect(
      container.read(appRouterProvider).state.matchedLocation,
      Routes.home,
    );
  });
}
