import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/utils/clock.dart';

part 'countdown_controller.g.dart';

/// Remaining time of a countdown, keyed by [id] (e.g. the OTP purpose value),
/// so the activate and change-password resend timers stay independent.
///
/// State is the remaining duration rounded up to whole seconds;
/// `Duration.zero` means not running (resend allowed).
///
/// ```dart
/// // resume from handoff: 3 min window since register/reset request
/// ref.read(countdownControllerProvider('ACTIVATE_DISTRIBUTOR').notifier)
///     .start(const Duration(minutes: 3), from: handoff.at);
/// ```
@riverpod
class CountdownController extends _$CountdownController {
  static const _tick = Duration(seconds: 1);

  Timer? _timer;
  DateTime? _endsAt;

  @override
  Duration build(String id) {
    ref.onDispose(_cancel);
    return Duration.zero;
  }

  bool get isRunning => state > Duration.zero;

  /// Starts (or restarts) a countdown of [total] measured from [from]
  /// (default: now). A [from] far enough in the past ends immediately.
  void start(Duration total, {DateTime? from}) {
    _cancel();
    _endsAt = (from ?? _now()).add(total);
    _update();
    if (isRunning) _timer = Timer.periodic(_tick, (_) => _update());
  }

  void stop() {
    _cancel();
    state = Duration.zero;
  }

  // Derived from the end time (not decremented) so timer drift and app
  // pauses never skew the remaining time.
  void _update() {
    final endsAt = _endsAt;
    final left = endsAt == null ? Duration.zero : endsAt.difference(_now());
    if (left <= Duration.zero) {
      _cancel();
      state = Duration.zero;
      return;
    }
    state = Duration(seconds: (left.inMilliseconds / 1000).ceil());
  }

  DateTime _now() => ref.read(clockProvider)();

  void _cancel() {
    _timer?.cancel();
    _timer = null;
  }
}
