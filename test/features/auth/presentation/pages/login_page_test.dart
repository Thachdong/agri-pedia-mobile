import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/app/router/app_router.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/core/router/routes.dart';
import 'package:ui_ux/features/auth/auth.dart' show CurrentUser;
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/auth_session_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/login_request.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/login_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/theme/app_theme.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';
import 'package:ui_ux/shared/widgets/app_text_field.dart';

import '../../../../fixtures/auth_fixtures.dart';
import '../../../../helpers/pump_app.dart';
import '../../../../helpers/register_form_driver.dart' show useTallView;

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

  /// Real app router at /auth/login (guest session).
  Future<void> pumpLoginRoute(
    WidgetTester tester, {
    LoginHandoff? handoff,
    String location = Routes.login,
  }) async {
    useTallView(tester);
    repo = _MockAuthRepository();
    store = _MockHandoffStore();
    session = _MockSessionRepository();
    when(() => store.readLogin()).thenAnswer((_) async => handoff);
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
    final router = container.read(appRouterProvider)..go(location);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(theme: buildAppTheme(), routerConfig: router),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  Finder loginButton() =>
      find.byWidgetPredicate((w) => w is AppButton && w.label == 'LOGIN');

  EditableText field(WidgetTester tester, int index) => tester
      .widgetList<EditableText>(find.byType(EditableText))
      .elementAt(index);

  Future<void> fill(
    WidgetTester tester,
    String identifier,
    String password,
  ) async {
    await tester.enterText(find.byType(EditableText).at(0), identifier);
    await tester.enterText(find.byType(EditableText).at(1), password);
  }

  Future<void> tapLogin(WidgetTester tester) async {
    await tester.tap(loginButton());
    await tester.pump();
    await tester.pump();
  }

  String? currentPath() =>
      container.read(appRouterProvider).state.matchedLocation;

  testWidgets('sections: header, title, tabs, 2 fields, LOGIN, footer', (
    tester,
  ) async {
    await pumpLoginRoute(tester);

    expect(find.text('Back To Home'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.text('PHONE'), findsOneWidget);
    expect(find.byType(AppTextField), findsNWidgets(2));
    expect(find.text('Mật khẩu'), findsOneWidget);
    expect(loginButton(), findsOneWidget);
    expect(find.text('Đăng ký'), findsOneWidget);
    expect(find.text('Kích hoạt'), findsOneWidget);
    expect(find.text('Reset mật khẩu'), findsOneWidget);
    expect(find.text('Đăng nhập'), findsNothing);
  });

  testWidgets('no handoff → EMAIL, identifier focused', (tester) async {
    await pumpLoginRoute(tester);

    expect(find.text('Email'), findsOneWidget);
    expect(field(tester, 0).focusNode.hasFocus, isTrue);
  });

  testWidgets('login handoff → prefilled, password focused', (tester) async {
    await pumpLoginRoute(
      tester,
      handoff: const LoginHandoff(
        loginType: LoginType.phone,
        identifier: '0901234567',
      ),
    );

    expect(find.text('Số điện thoại'), findsOneWidget);
    expect(field(tester, 0).controller.text, '0901234567');
    expect(field(tester, 1).focusNode.hasFocus, isTrue);
  });

  testWidgets('tab switch → identifier cleared', (tester) async {
    await pumpLoginRoute(tester);
    await tester.enterText(find.byType(EditableText).at(0), 'a@b.vn');

    await tester.tap(find.text('PHONE'));
    await tester.pump();

    expect(find.text('Số điện thoại'), findsOneWidget);
    expect(field(tester, 0).controller.text, isEmpty);
  });

  testWidgets('empty form → field errors, no request', (tester) async {
    await pumpLoginRoute(tester);

    await tapLogin(tester);

    expect(find.text('Vui lòng nhập email'), findsOneWidget);
    expect(find.text('Vui lòng nhập mật khẩu'), findsOneWidget);
    verifyZeroInteractions(repo);
  });

  testWidgets('loading → LOGIN shows spinner', (tester) async {
    await pumpLoginRoute(tester);
    final pending = Completer<void>();
    when(() => repo.login(any())).thenAnswer((_) async {
      await pending.future;
      throw const ApiException(code: 'X', message: 'x');
    });

    await fill(tester, 'a@b.vn', 'secret');
    await tapLogin(tester);

    expect(tester.widget<AppButton>(loginButton()).isLoading, isTrue);
    pending.complete();
    await tester.pumpAndSettle();
  });

  group('server errors (under the form)', () {
    Future<void> loginFailing(
      WidgetTester tester,
      String code,
      int status,
    ) async {
      await pumpLoginRoute(tester);
      when(
        () => repo.login(any()),
      ).thenThrow(ApiException(code: code, message: code, statusCode: status));
      await fill(tester, 'a@b.vn', 'secret');
      await tapLogin(tester);
    }

    testWidgets('USER_INVALID_CREDENTIALS → message, stays, clears on edit', (
      tester,
    ) async {
      await loginFailing(tester, 'USER_INVALID_CREDENTIALS', 401);

      const message = 'Email/số điện thoại hoặc mật khẩu không đúng.';
      expect(find.text(message), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppTextField),
          matching: find.text(message),
        ),
        findsNothing,
      );
      expect(find.text('Kích hoạt'), findsOneWidget); // footer link only
      expect(currentPath(), Routes.login);

      await tester.enterText(find.byType(EditableText).at(1), 'secret2');
      await tester.pump();
      expect(find.text(message), findsNothing);
    });

    testWidgets('USER_NOT_ACTIVE → message + activate link → /auth/activate', (
      tester,
    ) async {
      await loginFailing(tester, 'USER_NOT_ACTIVE', 403);

      expect(find.text('Tài khoản chưa được kích hoạt.'), findsOneWidget);
      // Footer link + the one under the error.
      expect(find.text('Kích hoạt'), findsNWidgets(2));

      await tester.tap(find.text('Kích hoạt').first);
      await tester.pumpAndSettle();
      expect(currentPath(), Routes.activate);
    });
  });

  group('success → router guard navigates', () {
    Future<void> loginAs(
      WidgetTester tester,
      CurrentUser user, {
      String? from,
    }) async {
      await pumpLoginRoute(
        tester,
        location: from == null
            ? Routes.login
            : Uri(
                path: Routes.login,
                queryParameters: {'from': from},
              ).toString(),
      );
      when(
        () => repo.login(any()),
      ).thenAnswer((_) async => (tokens: tokenPair, user: user));
      await fill(tester, ' farmer@example.com ', 'secret');
      await tapLogin(tester);
      await tester.pumpAndSettle();
    }

    testWidgets('FARMER → / ; trimmed request ; tokens saved', (tester) async {
      await loginAs(tester, farmerUser);

      verify(
        () => repo.login(
          const LoginRequest(
            loginType: LoginType.email,
            identifier: 'farmer@example.com',
            password: 'secret',
          ),
        ),
      ).called(1);
      verify(() => session.saveTokens(tokenPair)).called(1);
      verify(() => store.clearLogin()).called(1);
      expect(currentPath(), Routes.home);
    });

    testWidgets('DISTRIBUTOR → /profile/<id>', (tester) async {
      await loginAs(tester, distributorUser);

      expect(currentPath(), Routes.profile('u-1'));
    });

    testWidgets('?from= safe path wins over role', (tester) async {
      await loginAs(tester, distributorUser, from: Routes.home);

      expect(currentPath(), Routes.home);
    });
  });
}
