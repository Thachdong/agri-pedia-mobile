import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/core/utils/clock.dart';
import 'package:ui_ux/shared/controllers/countdown_controller.dart';

import '../../helpers/pump_app.dart';

void main() {
  // testWidgets gives fake timers; the clock is advanced together with them.
  late DateTime now;

  Future<void> advance(WidgetTester tester, Duration d) async {
    now = now.add(d);
    await tester.pump(d);
  }

  setUp(() => now = DateTime(2026, 10, 6, 12));

  testWidgets('counts down and stops at zero', (tester) async {
    final c = makeContainer(
      overrides: [clockProvider.overrideWithValue(() => now)],
    );
    final provider = countdownControllerProvider('ACTIVATE_DISTRIBUTOR');
    c.listen(provider, (_, _) {});

    c.read(provider.notifier).start(const Duration(seconds: 3));
    expect(c.read(provider), const Duration(seconds: 3));
    expect(c.read(provider.notifier).isRunning, isTrue);

    await advance(tester, const Duration(seconds: 1));
    expect(c.read(provider), const Duration(seconds: 2));

    await advance(tester, const Duration(seconds: 2));
    expect(c.read(provider), Duration.zero);
    expect(c.read(provider.notifier).isRunning, isFalse);
  });

  testWidgets('resumes from a past timestamp (handoff.at)', (tester) async {
    final c = makeContainer(
      overrides: [clockProvider.overrideWithValue(() => now)],
    );
    final provider = countdownControllerProvider('x');
    c.listen(provider, (_, _) {});
    final notifier = c.read(provider.notifier);

    notifier.start(
      const Duration(minutes: 3),
      from: now.subtract(const Duration(minutes: 1)),
    );
    expect(c.read(provider), const Duration(minutes: 2));

    notifier.start(
      const Duration(minutes: 3),
      from: now.subtract(const Duration(minutes: 4)),
    );
    expect(c.read(provider), Duration.zero);
  });

  testWidgets('rounds partial seconds up', (tester) async {
    final c = makeContainer(
      overrides: [clockProvider.overrideWithValue(() => now)],
    );
    final provider = countdownControllerProvider('x');
    c.listen(provider, (_, _) {});

    c.read(provider.notifier).start(const Duration(milliseconds: 2500));
    expect(c.read(provider), const Duration(seconds: 3));
    c.read(provider.notifier).stop();
  });

  testWidgets('restart and stop', (tester) async {
    final c = makeContainer(
      overrides: [clockProvider.overrideWithValue(() => now)],
    );
    final provider = countdownControllerProvider('x');
    c.listen(provider, (_, _) {});
    final notifier = c.read(provider.notifier);

    notifier.start(const Duration(seconds: 10));
    await advance(tester, const Duration(seconds: 4));
    notifier.start(const Duration(seconds: 10));
    expect(c.read(provider), const Duration(seconds: 10));

    notifier.stop();
    expect(c.read(provider), Duration.zero);
    await advance(tester, const Duration(seconds: 2));
    expect(c.read(provider), Duration.zero);
  });

  testWidgets('ids are independent', (tester) async {
    final c = makeContainer(
      overrides: [clockProvider.overrideWithValue(() => now)],
    );
    final a = countdownControllerProvider('ACTIVATE_DISTRIBUTOR');
    final b = countdownControllerProvider('RESET_PASSWORD');
    c
      ..listen(a, (_, _) {})
      ..listen(b, (_, _) {});

    c.read(a.notifier).start(const Duration(seconds: 5));
    expect(c.read(b), Duration.zero);
    c.read(a.notifier).stop();
  });

  testWidgets('dispose cancels the timer', (tester) async {
    final c = makeContainer(
      overrides: [clockProvider.overrideWithValue(() => now)],
    );
    final provider = countdownControllerProvider('x');
    final sub = c.listen(provider, (_, _) {});

    c.read(provider.notifier).start(const Duration(minutes: 1));
    sub.close();
    await tester.pump();
    // A pending periodic timer would fail the test at teardown.
    await advance(tester, const Duration(seconds: 2));
  });
}
