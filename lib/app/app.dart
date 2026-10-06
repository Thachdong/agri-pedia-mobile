import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_ux/app/router/app_router.dart';
import 'package:ui_ux/shared/theme/app_theme.dart';

final _theme = buildAppTheme();

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    title: 'AgriPedia',
    debugShowCheckedModeBanner: false,
    theme: _theme,
    themeMode: ThemeMode.light,
    routerConfig: ref.watch(appRouterProvider),
  );
}
