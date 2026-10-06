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
import 'package:ui_ux/features/auth/data/dtos/confirm_password_reset_request.dart';
import 'package:ui_ux/features/auth/data/dtos/resend_code_request.dart';
import 'package:ui_ux/features/auth/domain/models/auth_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/login_handoff.dart';
import 'package:ui_ux/features/auth/domain/models/otp_purpose.dart';
import 'package:ui_ux/shared/enums/login_type.dart';
import 'package:ui_ux/shared/theme/app_theme.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';
import 'package:ui_ux/shared/widgets/app_text_field.dart';
import 'package:ui_ux/shared/widgets/otp_input.dart';

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
      const LoginHandoff(loginType: LoginType.email, identifier: 'x'),
    );
    registerFallbackValue(
      const ConfirmPasswordResetRequest(
        identifier: 'x',
        code: '1',
        newPassword: 'x',
      ),
    );
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

  /// Real app router at /auth/change-password; [handoff] is what the store
  /// holds.
  Future<void> pumpChangeRoute(
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
    final router = container.read(appRouterProvider)..go(Routes.changePassword);
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

  /// identifier, password, confirm password (in that order).
  Finder textField(int index) => find
      .descendant(
        of: find.byType(AppTextField),
        matching: find.byType(EditableText),
      )
      .at(index);

  EditableText editable(WidgetTester tester, int index) =>
      tester.widget<EditableText>(textField(index));

  Finder codeField() => find.descendant(
    of: find.byType(OtpInput),
    matching: find.byType(EditableText),
  );

  Finder resendButton() => find.widgetWithText(AppButton, 'Gửi lại mã');

  Future<void> tapChange(WidgetTester tester) async {
    await tester.tap(find.widgetWithText(AppButton, 'CHANGE PASSWORD'));
    await tester.pump();
    await tester.pump();
  }

  Future<void> fillPasswordsAndCode(WidgetTester tester) async {
    await tester.enterText(textField(1), 'secret123');
    await tester.enterText(textField(2), 'secret123');
    await tester.enterText(codeField(), '123456');
  }

  /// Unmounts the page and disposes the container so the countdown's
  /// periodic timer is cancelled before the pending-timer check.
  Future<void> stopTimers(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    container.dispose();
  }

  String? currentPath() =>
      container.read(appRouterProvider).state.matchedLocation;

  testWidgets('sections: header, title, tabs, fields, code, resend, footer', (
    tester,
  ) async {
    await pumpChangeRoute(tester);

    expect(find.text('Back To Home'), findsOneWidget);
    expect(find.text('Change Password'), findsOneWidget);
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.byType(AppTextField), findsNWidgets(3));
    expect(find.byType(OtpInput), findsOneWidget);
    expect(find.text('Chưa nhận được mã?'), findsOneWidget);
    expect(find.text('CHANGE PASSWORD'), findsOneWidget);
    expect(find.text('Đăng ký'), findsOneWidget);
    expect(find.text('Đăng nhập'), findsOneWidget);
    expect(find.text('Kích hoạt'), findsNothing);
  });

  testWidgets('no handoff → EMAIL, identifier focused, resend enabled', (
    tester,
  ) async {
    await pumpChangeRoute(tester);

    expect(find.text('Email'), findsOneWidget);
    expect(editable(tester, 0).focusNode.hasFocus, isTrue);
    expect(editable(tester, 0).controller.text, isEmpty);
    expect(tester.widget<AppButton>(resendButton()).onPressed, isNotNull);
  });

  testWidgets('handoff < 3 min → prefilled, password focused, countdown', (
    tester,
  ) async {
    await pumpChangeRoute(
      tester,
      handoff: handoffSentAgo(const Duration(minutes: 1)),
    );

    expect(find.text('Số điện thoại'), findsOneWidget);
    expect(editable(tester, 0).controller.text, '0901234567');
    expect(editable(tester, 1).focusNode.hasFocus, isTrue);
    final resend = find.widgetWithText(AppButton, 'Gửi lại mã (02:00)');
    expect(resend, findsOneWidget);
    expect(tester.widget<AppButton>(resend).onPressed, isNull);
    await stopTimers(tester);
  });

  testWidgets('handoff > 3 min → no countdown, resend enabled', (tester) async {
    await pumpChangeRoute(
      tester,
      handoff: handoffSentAgo(const Duration(minutes: 4)),
    );

    expect(editable(tester, 0).controller.text, '0901234567');
    expect(tester.widget<AppButton>(resendButton()).onPressed, isNotNull);
  });

  testWidgets('tab switch clears identifier', (tester) async {
    await pumpChangeRoute(
      tester,
      handoff: handoffSentAgo(const Duration(minutes: 4)),
    );

    await tester.tap(find.text('EMAIL'));
    await tester.pump();

    expect(find.text('Email'), findsOneWidget);
    expect(editable(tester, 0).controller.text, isEmpty);
  });

  testWidgets('last code digit → CHANGE PASSWORD focused', (tester) async {
    await pumpChangeRoute(tester);

    await tester.enterText(codeField(), '123456');
    await tester.pump();

    expect(
      Focus.of(tester.element(find.text('CHANGE PASSWORD'))).hasFocus,
      isTrue,
    );
  });

  testWidgets('empty submit → field errors, no request', (tester) async {
    await pumpChangeRoute(tester);

    await tapChange(tester);

    expect(find.text('Vui lòng nhập email'), findsOneWidget);
    expect(find.text('Vui lòng nhập đủ 6 chữ số'), findsOneWidget);
    verifyZeroInteractions(repo);
  });

  testWidgets('confirm mismatch → error, no request', (tester) async {
    await pumpChangeRoute(
      tester,
      handoff: handoffSentAgo(const Duration(minutes: 4)),
    );

    await tester.enterText(textField(1), 'secret123');
    await tester.enterText(textField(2), 'secret124');
    await tester.enterText(codeField(), '123456');
    await tapChange(tester);

    expect(find.text('Mật khẩu xác nhận không khớp'), findsOneWidget);
    verifyZeroInteractions(repo);
  });

  testWidgets('success → request without confirm, handoff cleared, '
      '/auth/login', (tester) async {
    await pumpChangeRoute(
      tester,
      handoff: handoffSentAgo(const Duration(minutes: 1)),
    );
    when(() => repo.confirmPasswordReset(any())).thenAnswer((_) async {});

    await fillPasswordsAndCode(tester);
    await tapChange(tester);
    await tester.pumpAndSettle();

    verify(
      () => repo.confirmPasswordReset(
        const ConfirmPasswordResetRequest(
          identifier: '0901234567',
          code: '123456',
          newPassword: 'secret123',
        ),
      ),
    ).called(1);
    verify(() => store.clear(purpose)).called(1);
    expect(currentPath(), Routes.login);
  });

  group('server errors', () {
    Future<void> changeFailing(WidgetTester tester, String code) async {
      await pumpChangeRoute(
        tester,
        handoff: handoffSentAgo(const Duration(minutes: 4)),
      );
      when(
        () => repo.confirmPasswordReset(any()),
      ).thenThrow(ApiException(code: code, message: code, statusCode: 422));
      await fillPasswordsAndCode(tester);
      await tapChange(tester);
    }

    testWidgets('OTP_INVALID_CODE → under code', (tester) async {
      await changeFailing(tester, 'OTP_INVALID_CODE');

      expect(
        find.descendant(
          of: find.byType(OtpInput),
          matching: find.text('Mã xác thực không đúng.'),
        ),
        findsOneWidget,
      );
      verifyNever(() => store.clear(purpose));
    });

    testWidgets('OTP_NOT_FOUND → under identifier + reset link', (
      tester,
    ) async {
      await changeFailing(tester, 'OTP_NOT_FOUND');

      expect(
        find.descendant(
          of: find.byType(AppTextField).first,
          matching: find.text('Không tìm thấy mã xác thực cho tài khoản này.'),
        ),
        findsOneWidget,
      );
      await tester.tap(find.widgetWithText(AppButton, 'Yêu cầu mã mới'));
      await tester.pumpAndSettle();
      expect(currentPath(), Routes.resetPassword);
    });

    testWidgets('OTP_ALREADY_CONSUMED → under form + reset link', (
      tester,
    ) async {
      await changeFailing(tester, 'OTP_ALREADY_CONSUMED');

      expect(find.text('Mã xác thực đã được sử dụng.'), findsOneWidget);
      expect(find.widgetWithText(AppButton, 'Yêu cầu mã mới'), findsOneWidget);
    });

    testWidgets('OTP_BLOCKED → under form, no reset link', (tester) async {
      await changeFailing(tester, 'OTP_BLOCKED');

      expect(
        find.text('Bạn đã thử quá nhiều lần. Vui lòng thử lại sau.'),
        findsOneWidget,
      );
      expect(find.text('Yêu cầu mã mới'), findsNothing);
    });
  });

  testWidgets('resend → RESET_PASSWORD request, handoff saved, 03:00', (
    tester,
  ) async {
    await pumpChangeRoute(tester);
    when(() => repo.resendCode(any())).thenAnswer((_) async {});

    await tester.enterText(textField(0), ' a@b.vn ');
    await tester.tap(resendButton());
    await tester.pump();
    await tester.pump();

    verify(
      () => repo.resendCode(
        const ResendCodeRequest(identifier: 'a@b.vn', purpose: purpose),
      ),
    ).called(1);
    verify(
      () => store.save(
        AuthHandoff(
          loginType: LoginType.email,
          identifier: 'a@b.vn',
          at: now,
          purpose: purpose,
        ),
      ),
    ).called(1);
    expect(find.text('Gửi lại mã (03:00)'), findsOneWidget);
    await stopTimers(tester);
  });
}
