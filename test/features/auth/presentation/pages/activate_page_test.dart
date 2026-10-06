import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/app/router/app_router.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/core/router/routes.dart';
import 'package:ui_ux/core/utils/clock.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/activate_request.dart';
import 'package:ui_ux/features/auth/data/dtos/resend_code_request.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/login_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/theme/app_theme.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';
import 'package:ui_ux/shared/widgets/otp_input.dart';

import '../../../../helpers/pump_app.dart';
import '../../../../helpers/register_form_driver.dart' show useTallView;

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
      const LoginHandoff(loginType: LoginType.email, identifier: 'x'),
    );
    registerFallbackValue(const ActivateRequest(identifier: 'x', code: '1'));
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

  /// Real app router at /auth/activate; [handoff] is what the store holds.
  Future<void> pumpActivateRoute(
    WidgetTester tester, {
    AuthHandoff? handoff,
  }) async {
    useTallView(tester);
    repo = _MockAuthRepository();
    store = _MockHandoffStore();
    when(() => store.saveLogin(any())).thenAnswer((_) async {});
    when(() => store.read(purpose)).thenAnswer((_) async => handoff);
    when(() => store.save(any())).thenAnswer((_) async {});
    when(() => store.clear(purpose)).thenAnswer((_) async {});
    container = makeContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        authHandoffStoreProvider.overrideWithValue(store),
        clockProvider.overrideWithValue(() => now),
      ],
    );
    final router = container.read(appRouterProvider)..go(Routes.activate);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(theme: buildAppTheme(), routerConfig: router),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  AuthHandoff handoffSentAgo(Duration ago) => AuthHandoff(
    loginType: LoginType.phone,
    identifier: '0901234567',
    at: now.subtract(ago),
    purpose: purpose,
  );

  EditableText identifierField(WidgetTester tester) =>
      tester.widget<EditableText>(find.byType(EditableText).first);

  Finder codeField() => find.descendant(
    of: find.byType(OtpInput),
    matching: find.byType(EditableText),
  );

  Finder resendButton() => find.widgetWithText(AppButton, 'Gửi lại mã');

  Future<void> tapActivate(WidgetTester tester) async {
    await tester.tap(find.widgetWithText(AppButton, 'ACTIVATE'));
    await tester.pump();
    await tester.pump();
  }

  /// Unmounts the page and disposes the container so the countdown's
  /// periodic timer is cancelled before the pending-timer check.
  Future<void> stopTimers(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    container.dispose();
  }

  String? currentPath() =>
      container.read(appRouterProvider).state.matchedLocation;

  testWidgets('sections: header, title, tabs, code, resend, footer', (
    tester,
  ) async {
    await pumpActivateRoute(tester);

    expect(find.text('Back To Home'), findsOneWidget);
    expect(find.text('Activate Account'), findsOneWidget);
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.byType(OtpInput), findsOneWidget);
    expect(find.text('Chưa nhận được mã?'), findsOneWidget);
    expect(find.text('ACTIVATE'), findsOneWidget);
    expect(find.text('Đăng ký'), findsOneWidget);
    expect(find.text('Đăng nhập'), findsOneWidget);
    expect(find.text('Reset mật khẩu'), findsOneWidget);
  });

  testWidgets('no handoff → EMAIL, identifier focused, resend enabled', (
    tester,
  ) async {
    await pumpActivateRoute(tester);

    expect(find.text('Email'), findsOneWidget);
    expect(identifierField(tester).focusNode.hasFocus, isTrue);
    expect(identifierField(tester).controller.text, isEmpty);
    expect(tester.widget<AppButton>(resendButton()).onPressed, isNotNull);
  });

  testWidgets('handoff < 3 min → prefilled, code focused, countdown', (
    tester,
  ) async {
    await pumpActivateRoute(
      tester,
      handoff: handoffSentAgo(const Duration(minutes: 1)),
    );

    expect(find.text('Số điện thoại'), findsOneWidget);
    expect(identifierField(tester).controller.text, '0901234567');
    expect(tester.widget<EditableText>(codeField()).focusNode.hasFocus, isTrue);
    final resend = find.widgetWithText(AppButton, 'Gửi lại mã (02:00)');
    expect(resend, findsOneWidget);
    expect(tester.widget<AppButton>(resend).onPressed, isNull);
    await stopTimers(tester);
  });

  testWidgets('handoff > 3 min → prefilled, no countdown, resend enabled', (
    tester,
  ) async {
    await pumpActivateRoute(
      tester,
      handoff: handoffSentAgo(const Duration(minutes: 4)),
    );

    expect(identifierField(tester).controller.text, '0901234567');
    expect(tester.widget<AppButton>(resendButton()).onPressed, isNotNull);
  });

  testWidgets('tab switch clears identifier', (tester) async {
    await pumpActivateRoute(
      tester,
      handoff: handoffSentAgo(const Duration(minutes: 4)),
    );

    await tester.tap(find.text('EMAIL'));
    await tester.pump();

    expect(find.text('Email'), findsOneWidget);
    expect(identifierField(tester).controller.text, isEmpty);
  });

  testWidgets('last code digit → ACTIVATE focused', (tester) async {
    await pumpActivateRoute(tester);

    await tester.enterText(codeField(), '123456');
    await tester.pump();

    final activate = find.widgetWithText(AppButton, 'ACTIVATE');
    expect(
      Focus.of(
        tester.element(
          find.descendant(of: activate, matching: find.text('ACTIVATE')),
        ),
      ).hasFocus,
      isTrue,
    );
  });

  testWidgets('empty submit → field errors, no request', (tester) async {
    await pumpActivateRoute(tester);

    await tapActivate(tester);

    expect(find.text('Vui lòng nhập email'), findsOneWidget);
    expect(find.text('Vui lòng nhập đủ 6 chữ số'), findsOneWidget);
    verifyZeroInteractions(repo);
  });

  testWidgets('success → trimmed request, handoff cleared, /auth/login', (
    tester,
  ) async {
    await pumpActivateRoute(
      tester,
      handoff: handoffSentAgo(const Duration(minutes: 1)),
    );
    when(() => repo.activate(any())).thenAnswer((_) async {});

    await tester.enterText(codeField(), '123456');
    await tapActivate(tester);
    await tester.pumpAndSettle();

    verify(
      () => repo.activate(
        const ActivateRequest(identifier: '0901234567', code: '123456'),
      ),
    ).called(1);
    verify(() => store.clear(purpose)).called(1);
    expect(currentPath(), Routes.login);
  });

  group('server errors', () {
    Future<void> activateFailing(WidgetTester tester, String code) async {
      await pumpActivateRoute(
        tester,
        handoff: handoffSentAgo(const Duration(minutes: 4)),
      );
      when(
        () => repo.activate(any()),
      ).thenThrow(ApiException(code: code, message: code, statusCode: 422));
      await tester.enterText(codeField(), '123456');
      await tapActivate(tester);
    }

    testWidgets('OTP_INVALID_CODE → under code', (tester) async {
      await activateFailing(tester, 'OTP_INVALID_CODE');

      final message = find.text('Mã xác thực không đúng.');
      expect(message, findsOneWidget);
      expect(
        find.descendant(of: find.byType(OtpInput), matching: message),
        findsOneWidget,
      );
    });

    testWidgets('OTP_ALREADY_CONSUMED → under form + login link', (
      tester,
    ) async {
      await activateFailing(tester, 'OTP_ALREADY_CONSUMED');

      expect(find.text('Tài khoản đã được kích hoạt.'), findsOneWidget);
      // Footer link + the one next to the error.
      expect(find.text('Đăng nhập'), findsNWidgets(2));
      verifyNever(() => store.clear(purpose));
    });
  });

  group('resend', () {
    testWidgets('invalid identifier → error, no request', (tester) async {
      await pumpActivateRoute(tester);

      await tester.tap(resendButton());
      await tester.pump();

      expect(find.text('Vui lòng nhập email'), findsOneWidget);
      verifyZeroInteractions(repo);
    });

    testWidgets('success → handoff saved, countdown 03:00', (tester) async {
      await pumpActivateRoute(tester);
      when(() => repo.resendCode(any())).thenAnswer((_) async {});

      await tester.enterText(find.byType(EditableText).first, ' npp@a.vn ');
      await tester.tap(resendButton());
      await tester.pump();
      await tester.pump();

      verify(
        () => repo.resendCode(
          const ResendCodeRequest(identifier: 'npp@a.vn', purpose: purpose),
        ),
      ).called(1);
      verify(
        () => store.save(
          AuthHandoff(
            loginType: LoginType.email,
            identifier: 'npp@a.vn',
            at: now,
            purpose: purpose,
          ),
        ),
      ).called(1);
      expect(find.text('Gửi lại mã (03:00)'), findsOneWidget);
      await stopTimers(tester);
    });

    testWidgets('OTP_NOT_FOUND → under identifier', (tester) async {
      await pumpActivateRoute(tester);
      when(() => repo.resendCode(any())).thenThrow(
        const ApiException(
          code: 'OTP_NOT_FOUND',
          message: 'nf',
          statusCode: 404,
        ),
      );

      await tester.enterText(find.byType(EditableText).first, 'npp@a.vn');
      await tester.tap(resendButton());
      await tester.pump();
      await tester.pump();

      expect(
        find.text('Không tìm thấy mã xác thực cho tài khoản này.'),
        findsOneWidget,
      );
      verifyNever(() => store.save(any()));
    });
  });
}
