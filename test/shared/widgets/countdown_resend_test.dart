import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/shared/widgets/countdown_resend.dart';

import '../../helpers/pump_app.dart';

void main() {
  late int taps;

  Future<void> pump(
    WidgetTester tester,
    Duration remaining, {
    bool isSending = false,
  }) {
    return tester.pumpApp(
      SizedBox(
        width: 320,
        child: CountdownResend(
          remaining: remaining,
          onResend: () => taps++,
          isSending: isSending,
        ),
      ),
    );
  }

  setUp(() => taps = 0);

  testWidgets('counting: shows mm:ss and is disabled', (tester) async {
    await pump(tester, const Duration(seconds: 95));
    expect(find.text('Gửi lại mã (01:35)'), findsOneWidget);
    await tester.tap(find.textContaining('Gửi lại mã'));
    expect(taps, 0);
  });

  testWidgets('zero: enabled without countdown', (tester) async {
    await pump(tester, Duration.zero);
    await tester.tap(find.text('Gửi lại mã'));
    expect(taps, 1);
  });

  testWidgets('sending: spinner, not tappable', (tester) async {
    await pump(tester, Duration.zero, isSending: true);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Gửi lại mã'), findsNothing);
  });
}
