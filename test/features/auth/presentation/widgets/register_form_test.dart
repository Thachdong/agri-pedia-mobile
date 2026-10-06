import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_ux/core/network/api_exception.dart';
import 'package:ui_ux/features/auth/data/auth_handoff_store.dart';
import 'package:ui_ux/features/auth/data/auth_repository.dart';
import 'package:ui_ux/features/auth/data/dtos/register_request.dart';
import 'package:ui_ux/features/auth/presentation/widgets/register_form.dart';
import 'package:ui_ux/shared/enums/user_role.dart';
import 'package:ui_ux/shared/widgets/app_button.dart';

import '../../../../fixtures/auth_fixtures.dart';
import '../../../../helpers/pump_app.dart';
import '../../../../helpers/register_form_driver.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockHandoffStore extends Mock implements AuthHandoffStore {}

void main() {
  late _MockAuthRepository repo;

  setUpAll(() => registerFallbackValue(farmerRequest));

  setUp(() => repo = _MockAuthRepository());

  Future<void> pumpForm(WidgetTester tester) async {
    useTallView(tester);
    await tester.pumpApp(
      const SingleChildScrollView(child: RegisterForm()),
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        authHandoffStoreProvider.overrideWithValue(_MockHandoffStore()),
        ...locationOverrides,
      ],
    );
    await tester.pumpAndSettle();
  }

  void failWith(String code) => when(
    () => repo.register(any()),
  ).thenThrow(ApiException(code: code, message: code, statusCode: 400));

  testWidgets('empty submit → field errors, no request', (tester) async {
    await pumpForm(tester);

    await tester.tap(find.text('Nhà phân phối'));
    await tester.pumpAndSettle();
    await tapRegister(tester);
    await tester.pumpAndSettle();

    for (final message in [
      'Vui lòng nhập email',
      'Vui lòng nhập mật khẩu',
      'Vui lòng nhập lại mật khẩu',
      'Vui lòng chọn loại hình kinh doanh',
      'Vui lòng chọn tỉnh/thành phố',
      'Vui lòng chọn phường/xã',
      'Vui lòng nhập số nhà, tên đường',
      'Vui lòng chọn vị trí trên bản đồ',
    ]) {
      expect(find.text(message), findsOneWidget, reason: message);
    }
    verifyZeroInteractions(repo);
  });

  testWidgets('role toggles the business type field', (tester) async {
    await pumpForm(tester);

    expect(find.text('Loại hình kinh doanh'), findsNothing);
    await tester.tap(find.text('Nhà phân phối'));
    await tester.pumpAndSettle();
    expect(find.text('Loại hình kinh doanh'), findsOneWidget);
    await tester.tap(find.text('Nông dân'));
    await tester.pumpAndSettle();
    expect(find.text('Loại hình kinh doanh'), findsNothing);
  });

  testWidgets('tab switch clears identifier and swaps the rule', (
    tester,
  ) async {
    await pumpForm(tester);

    await tester.enterText(find.byType(EditableText).first, 'a@b.vn');
    await tester.tap(find.text('PHONE'));
    await tester.pumpAndSettle();

    expect(find.text('Số điện thoại'), findsOneWidget);
    expect(find.text('a@b.vn'), findsNothing);
    await tapRegister(tester);
    await tester.pumpAndSettle();
    expect(find.text('Vui lòng nhập số điện thoại'), findsOneWidget);
  });

  testWidgets('FARMER submit sends bussinessType null even if picked', (
    tester,
  ) async {
    when(
      () => repo.register(any()),
    ).thenThrow(const ApiException(code: 'UNKNOWN', message: 'stop here'));
    await pumpForm(tester);
    await fillRegisterForm(tester, distributor: true);
    await tester.tap(find.text('Nông dân'));
    await tester.pumpAndSettle();

    await tapRegister(tester);
    await tester.pumpAndSettle();

    final request =
        verify(() => repo.register(captureAny())).captured.single
            as RegisterRequest;
    expect(request.role, UserRole.farmer);
    expect(request.bussinessType, isNull);
  });

  testWidgets('loading: REGISTER spinner + fields disabled', (tester) async {
    final pending = Completer<void>();
    when(() => repo.register(any())).thenAnswer((_) => pending.future);
    await pumpForm(tester);
    await fillRegisterForm(tester);

    await tapRegister(tester);

    final button = tester.widget<AppButton>(find.byType(AppButton).last);
    expect(button.isLoading, isTrue);
    expect(
      tester.widget<TextField>(find.byType(TextField).first).enabled,
      isFalse,
    );
    pending.completeError(const ApiException(code: 'UNKNOWN', message: 'stop'));
    await tester.pumpAndSettle();
  });

  testWidgets(
    'USER_IDENTIFIER_ALREADY_USED → under identifier, clears on edit',
    (tester) async {
      failWith('USER_IDENTIFIER_ALREADY_USED');
      await pumpForm(tester);
      await fillRegisterForm(tester);

      await tapRegister(tester);
      await tester.pumpAndSettle();

      const message = 'Email/số điện thoại này đã được dùng để đăng ký.';
      expect(find.text(message), findsOneWidget);
      await tester.enterText(
        find.byType(EditableText).first,
        'new@example.com',
      );
      await tester.pump();
      expect(find.text(message), findsNothing);
    },
  );

  testWidgets('USER_LOCATION_INVALID → under the address section', (
    tester,
  ) async {
    failWith('USER_LOCATION_INVALID');
    await pumpForm(tester);
    await fillRegisterForm(tester);

    await tapRegister(tester);
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Tỉnh/thành phố hoặc phường/xã không hợp lệ. Vui lòng chọn lại.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('USER_BUSINESS_TYPE_REQUIRED → under business type', (
    tester,
  ) async {
    failWith('USER_BUSINESS_TYPE_REQUIRED');
    await pumpForm(tester);
    await fillRegisterForm(tester, distributor: true);

    await tapRegister(tester);
    await tester.pumpAndSettle();

    expect(find.text('Vui lòng chọn loại hình kinh doanh.'), findsOneWidget);
  });

  testWidgets('network error → message under the form', (tester) async {
    failWith(ApiException.networkError);
    await pumpForm(tester);
    await fillRegisterForm(tester);

    await tapRegister(tester);
    await tester.pumpAndSettle();

    expect(
      find.text('Không có kết nối mạng. Vui lòng kiểm tra và thử lại.'),
      findsOneWidget,
    );
  });
}
