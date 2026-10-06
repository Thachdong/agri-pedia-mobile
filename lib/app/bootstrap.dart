import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_ux/app/app.dart';
import 'package:ui_ux/core/config/env.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  Env.assertConfigured();
  runApp(const ProviderScope(child: App()));
}
