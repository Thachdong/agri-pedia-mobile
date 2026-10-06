import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock.g.dart';

/// Current time source; override in tests to control time.
@Riverpod(keepAlive: true)
DateTime Function() clock(Ref ref) => DateTime.now;
