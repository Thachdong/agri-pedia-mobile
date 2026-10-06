import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_ux/shared/theme/app_theme.dart';

/// Wraps [child] in the app theme + a Scaffold (+ ProviderScope).
Widget wrapApp(Widget child, {List<Override> overrides = const []}) =>
    ProviderScope(
      overrides: overrides,
      retry: (_, _) => null,
      child: MaterialApp(
        theme: buildAppTheme(),
        home: Scaffold(body: child),
      ),
    );

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget child, {List<Override> overrides = const []}) =>
      pumpWidget(wrapApp(child, overrides: overrides));
}

/// Container disposed at the end of the test. Riverpod's automatic retry of
/// failed providers is off so errors are observable immediately.
ProviderContainer makeContainer({List<Override> overrides = const []}) {
  final container = ProviderContainer(
    overrides: overrides,
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  return container;
}
