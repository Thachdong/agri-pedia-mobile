// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countdown_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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

@ProviderFor(CountdownController)
final countdownControllerProvider = CountdownControllerFamily._();

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
final class CountdownControllerProvider
    extends $NotifierProvider<CountdownController, Duration> {
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
  CountdownControllerProvider._({
    required CountdownControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'countdownControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$countdownControllerHash();

  @override
  String toString() {
    return r'countdownControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CountdownController create() => CountdownController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CountdownControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$countdownControllerHash() =>
    r'62a883d51ebb304f430dedeaa51526663962da7b';

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

final class CountdownControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CountdownController,
          Duration,
          Duration,
          Duration,
          String
        > {
  CountdownControllerFamily._()
    : super(
        retry: null,
        name: r'countdownControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

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

  CountdownControllerProvider call(String id) =>
      CountdownControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'countdownControllerProvider';
}

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

abstract class _$CountdownController extends $Notifier<Duration> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  Duration build(String id);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Duration, Duration>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Duration, Duration>,
              Duration,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
