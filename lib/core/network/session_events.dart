import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_events.g.dart';

/// Session signals raised by core (the auth interceptor) for features to
/// react to. core can't import the auth feature, so it emits here and
/// `authStateProvider` listens.
class SessionEvents {
  final _expired = StreamController<void>.broadcast();

  /// Fires when the refresh token was rejected; tokens are already cleared.
  Stream<void> get expired => _expired.stream;

  void notifyExpired() {
    if (!_expired.isClosed) _expired.add(null);
  }

  Future<void> dispose() => _expired.close();
}

@Riverpod(keepAlive: true)
SessionEvents sessionEvents(Ref ref) {
  final events = SessionEvents();
  ref.onDispose(events.dispose);
  return events;
}
