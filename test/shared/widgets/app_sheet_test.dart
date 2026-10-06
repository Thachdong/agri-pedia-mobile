import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/shared/widgets/app_sheet.dart';

import '../../helpers/pump_app.dart';

void main() {
  Future<void> pumpOpener(
    WidgetTester tester,
    Future<void> Function(BuildContext context) open,
  ) => tester.pumpApp(
    Builder(
      builder: (context) =>
          TextButton(onPressed: () => open(context), child: const Text('open')),
    ),
  );

  testWidgets('long form sheet scrolls and returns the popped value', (
    tester,
  ) async {
    bool? result;
    await pumpOpener(tester, (context) async {
      result = await showAppSheet<bool>(
        context,
        title: 'Đánh giá shop',
        builder: (sheet) => Column(
          children: [
            const TextField(),
            ...List.generate(30, (i) => Text('line $i')),
            TextButton(
              onPressed: () => Navigator.pop(sheet, true),
              child: const Text('Gửi'),
            ),
          ],
        ),
      );
    });

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('Đánh giá shop'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Gửi'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Gửi'));
    await tester.pumpAndSettle();
    expect(result, isTrue);
  });

  testWidgets('fullHeight sheet gives Expanded room; close button pops', (
    tester,
  ) async {
    await pumpOpener(
      tester,
      (context) => showAppSheet<void>(
        context,
        title: 'Chat',
        fullHeight: true,
        builder: (_) => const Column(
          children: [
            Expanded(child: Placeholder()),
            TextField(),
          ],
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.byType(Placeholder), findsOneWidget);

    await tester.tap(find.byTooltip('Đóng'));
    await tester.pumpAndSettle();
    expect(find.text('Chat'), findsNothing);
  });
}
