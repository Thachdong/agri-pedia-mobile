import 'dart:async';

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
import 'package:ui_ux/features/auth/data/dtos/request_password_reset_request.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/theme/app_theme.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';
import 'package:ui_ux/shared/widgets/app_text_field.dart';

import '../../../../helpers/pump_app.dart';
import '../../../../helpers/register_form_driver.dart' show useTallView;

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockHandoffStore extends Mock implements AuthHandoffStore {}

void main() {
  const purpose = OtpPurpose.resetPassword;
  final now = DateTime(2026, 10, 6, 9);

  late _MockAuthRepository repo;
  late _MockHandoffStore store;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(
      const RequestPasswordResetRequest(
        loginType: LoginType.email,
        identifier: 'x',
      ),
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

  /// Real app router at /auth/reset-password.
  Future<void> pumpResetRoute(WidgetTester tester) async {
    useTallView(tester);
    repo = _MockAuthRepository();
    store = _MockHandoffStore();
    when(() => store.read(purpose)).thenAnswer((_) async => null);
    when(() => store.save(any())).thenAnswer((_) async {});
    container = makeContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        authHandoffStoreProvider.overrideWithValue(store),
        clockProvider.overrideWithValue(() => now),
      ],
    );
    final router = container.read(appRouterProvider)..go(Routes.resetPassword);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(theme: buildAppTheme(), routerConfig: router),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  EditableText identifierField(WidgetTester tester) =>
      tester.widget<EditableText>(find.byType(EditableText));

  // By label prop: while loading the label text is replaced by a spinner.
  Finder resetButton() =>
      find.byWidgetPredicate((w) => w is AppButton && w.label == 'RESET');

  Future<void> tapReset(WidgetTester tester) async {
    await tester.tap(resetButton());
    await tester.pump();
    await tester.pump();
  }

  String? currentPath() =>
      container.read(appRouterProvider).state.matchedLocation;

  testWidgets('sections: header, title, tabs, identifier, RESET, footer', (
    tester,
  ) async {
    await pumpResetRoute(tester);

    expect(find.text('Back To Home'), findsOneWidget);
    expect(find.text('Reset Password'), findsOneWidget);
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.text('PHONE'), findsOneWidget);
    expect(find.byType(AppTextField), findsOneWidget);
    expect(resetButton(), findsOneWidget);
    expect(find.text('Đăng ký'), findsOneWidget);
    expect(find.text('Đăng nhập'), findsOneWidget);
    expect(find.text('Kích hoạt'), findsOneWidget);
    expect(find.text('Reset mật khẩu'), findsNothing);
  });

  testWidgets('init → EMAIL, identifier focused', (tester) async {
    await pumpResetRoute(tester);

    expect(find.text('Email'), findsOneWidget);
    expect(identifierField(tester).focusNode.hasFocus, isTrue);
  });

  testWidgets('tab switch → label changes, identifier cleared', (tester) async {
    await pumpResetRoute(tester);
    await tester.enterText(find.byType(EditableText), 'a@b.vn');

    await tester.tap(find.text('PHONE'));
    await tester.pump();

    expect(find.text('Số điện thoại'), findsOneWidget);
    expect(identifierField(tester).controller.text, isEmpty);
  });

  testWidgets('invalid identifier → field error, no request', (tester) async {
    await pumpResetRoute(tester);

    await tapReset(tester);
    expect(find.text('Vui lòng nhập email'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'not-an-email');
    await tapReset(tester);
    expect(find.text('Vui lòng nhập email'), findsNothing);
    verifyZeroInteractions(repo);
  });

  testWidgets('loading → RESET disabled', (tester) async {
    await pumpResetRoute(tester);
    final pending = Completer<DateTime?>();
    when(
      () => repo.requestPasswordReset(any()),
    ).thenAnswer((_) => pending.future);

    await tester.enterText(find.byType(EditableText), 'a@b.vn');
    await tapReset(tester);

    expect(tester.widget<AppButton>(resetButton()).isLoading, isTrue);
    pending.complete(null);
    await tester.pumpAndSettle();
  });

  testWidgets('success → trimmed request, handoff saved, change-password', (
    tester,
  ) async {
    await pumpResetRoute(tester);
    when(() => repo.requestPasswordReset(any())).thenAnswer((_) async => null);

    await tester.tap(find.text('PHONE'));
    await tester.pump();
    await tester.enterText(find.byType(EditableText), ' 0901234567 ');
    await tapReset(tester);
    await tester.pumpAndSettle();

    verify(
      () => repo.requestPasswordReset(
        const RequestPasswordResetRequest(
          loginType: LoginType.phone,
          identifier: '0901234567',
        ),
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
    expect(currentPath(), Routes.changePassword);
  });

  group('server errors', () {
    Future<void> resetFailing(
      WidgetTester tester,
      String code,
      int status,
    ) async {
      await pumpResetRoute(tester);
      when(
        () => repo.requestPasswordReset(any()),
      ).thenThrow(ApiException(code: code, message: code, statusCode: status));
      await tester.enterText(find.byType(EditableText), 'a@b.vn');
      await tapReset(tester);
    }

    testWidgets('OTP_ACCOUNT_NOT_FOUND → under identifier', (tester) async {
      await resetFailing(tester, 'OTP_ACCOUNT_NOT_FOUND', 404);

      final message = find.text(
        'Không tìm thấy tài khoản với email/số điện thoại này.',
      );
      expect(
        find.descendant(of: find.byType(AppTextField), matching: message),
        findsOneWidget,
      );
      expect(currentPath(), Routes.resetPassword);
      verifyNever(() => store.save(any()));
    });

    testWidgets('OTP_ACCOUNT_NOT_ACTIVE → under form + activate link', (
      tester,
    ) async {
      await resetFailing(tester, 'OTP_ACCOUNT_NOT_ACTIVE', 403);

      expect(find.text('Tài khoản chưa được kích hoạt.'), findsOneWidget);
      // Footer link + the one next to the error.
      expect(find.text('Kích hoạt'), findsNWidgets(2));

      // The error link is above the footer.
      await tester.tap(find.widgetWithText(AppButton, 'Kích hoạt').first);
      await tester.pumpAndSettle();
      expect(currentPath(), Routes.activate);
    });

    testWidgets('OTP_BLOCKED → under form', (tester) async {
      await resetFailing(tester, 'OTP_BLOCKED', 422);

      expect(
        find.text('Bạn đã thử quá nhiều lần. Vui lòng thử lại sau.'),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(AppTextField),
          matching: find.textContaining('thử quá nhiều'),
        ),
        findsNothing,
      );
    });
  });
}
