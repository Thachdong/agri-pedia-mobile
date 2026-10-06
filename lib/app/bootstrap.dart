import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_ux/app/app.dart';
import 'package:ui_ux/core/config/env.dart';
import 'package:ui_ux/core/network/retry_policy.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  Env.assertConfigured();
  runApp(const ProviderScope(retry: providerRetry, child: App()));
}
