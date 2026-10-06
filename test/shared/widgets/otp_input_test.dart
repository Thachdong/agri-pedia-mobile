import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/shared/widgets/otp_input.dart';

import '../../helpers/pump_app.dart';

void main() {
  late TextEditingController controller;
  late List<String> completed;

  Future<void> pumpOtp(
    WidgetTester tester, {
    GlobalKey<FormState>? formKey,
    String? errorText,
    bool enabled = true,
  }) {
    completed = [];
    controller = TextEditingController();
    addTearDown(controller.dispose);
    return tester.pumpApp(
      Form(
        key: formKey,
        child: OtpInput(
          controller: controller,
          onCompleted: completed.add,
          errorText: errorText,
          enabled: enabled,
          validator: (v) =>
              (v ?? '').length < 6 ? 'Vui lòng nhập đủ 6 chữ số' : null,
        ),
      ),
    );
  }

  Future<void> type(WidgetTester tester, String text) async {
    await tester.enterText(find.byType(TextField), text);
    await tester.pump();
  }

  testWidgets('typing fills boxes left to right', (tester) async {
    await pumpOtp(tester);
    await type(tester, '12');
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(completed, isEmpty);
  });

  testWidgets('backspace removes the last digit', (tester) async {
    await pumpOtp(tester);
    await type(tester, '123');
    await type(tester, '12');
    expect(find.text('3'), findsNothing);
    expect(controller.text, '12');
  });

  testWidgets('paste drops non-digits, caps length, completes', (tester) async {
    await pumpOtp(tester);
    await type(tester, '98 76-54321');
    expect(controller.text, '987654');
    expect(completed, ['987654']);
  });

  testWidgets('caret stays at the end', (tester) async {
    await pumpOtp(tester);
    await type(tester, '123');
    controller.selection = const TextSelection.collapsed(offset: 1);
    await tester.pump();
    expect(controller.selection.baseOffset, 3);
  });

  testWidgets('validator runs through the Form', (tester) async {
    final formKey = GlobalKey<FormState>();
    await pumpOtp(tester, formKey: formKey);
    await type(tester, '123');
    expect(formKey.currentState!.validate(), isFalse);
    await tester.pump();
    expect(find.text('Vui lòng nhập đủ 6 chữ số'), findsOneWidget);

    await type(tester, '123456');
    expect(formKey.currentState!.validate(), isTrue);
  });

  testWidgets('server errorText is shown', (tester) async {
    await pumpOtp(tester, errorText: 'Mã không đúng');
    expect(find.text('Mã không đúng'), findsOneWidget);
  });

  testWidgets('controller.clear empties the boxes', (tester) async {
    await pumpOtp(tester);
    await type(tester, '1234');
    controller.clear();
    await tester.pump();
    expect(find.text('1'), findsNothing);
  });

  testWidgets('disabled field ignores input', (tester) async {
    await pumpOtp(tester, enabled: false);
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.enabled, isFalse);
  });
}
