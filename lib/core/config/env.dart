/// Compile-time configuration from `--dart-define-from-file=env/<name>.json`.
/// The only place allowed to read `String.fromEnvironment`.
abstract final class Env {
  static const apiUrl = String.fromEnvironment('API_URL');
  static const socketUrl = String.fromEnvironment('SOCKET_URL');
  static const mapTileUrl = String.fromEnvironment(
    'MAP_TILE_URL',
    defaultValue: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  );

  /// Fails fast when the app was started without an env file.
  static void assertConfigured() {
    final missing = [
      if (apiUrl.isEmpty) 'API_URL',
      if (socketUrl.isEmpty) 'SOCKET_URL',
    ];
    if (missing.isNotEmpty) {
      throw StateError(
        'Missing env: ${missing.join(', ')}. '
        'Run with --dart-define-from-file=env/dev.json',
      );
    }
  }
}
