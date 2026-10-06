import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ui_ux/core/device/geo_point.dart';

part 'geolocation_service.g.dart';

/// Wraps geolocator. Asks for permission when needed.
class GeolocationService {
  const GeolocationService();

  static const _timeLimit = Duration(seconds: 15);

  /// Current position, or null when location is off, permission is denied,
  /// or the fix times out. Never throws to the UI.
  Future<GeoPoint?> currentPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever ||
          permission == LocationPermission.unableToDetermine) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(timeLimit: _timeLimit),
      );
      return GeoPoint(lat: position.latitude, long: position.longitude);
    } on TimeoutException {
      return null;
    } on Exception {
      return null;
    }
  }
}

@Riverpod(keepAlive: true)
GeolocationService geolocationService(Ref ref) => const GeolocationService();
