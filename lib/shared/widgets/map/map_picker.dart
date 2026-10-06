import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ui_ux/core/config/env.dart';
import 'package:ui_ux/core/device/geo_point.dart';
import 'package:ui_ux/shared/extensions/theme_context.dart';

/// OSM map to pick one point: tap anywhere to place / move the marker.
///
/// [value] null → no marker, camera on [initialCenter] (default: whole VN).
/// When [value] changes from outside (e.g. "Dùng vị trí hiện tại"), the
/// camera follows it; points picked by tapping don't move the camera.
/// Size comes from the parent (wrap in `SizedBox` / `Expanded`).
class MapPicker extends StatefulWidget {
  const MapPicker({
    required this.value,
    required this.onChanged,
    super.key,
    this.initialCenter,
  });

  final GeoPoint? value;
  final ValueChanged<GeoPoint> onChanged;
  final GeoPoint? initialCenter;

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  /// Geographic center of Vietnam, zoomed to show the whole country.
  static const _vietnam = LatLng(16.05, 106.5);
  static const _countryZoom = 5.0;
  static const _pointZoom = 16.0;
  static const _markerSize = 48.0;

  /// Must match the app id (OSM tile usage policy).
  static const _userAgentPackageName = 'com.example.ui_ux';

  final _controller = MapController();
  bool _ready = false;
  GeoPoint? _lastPicked;

  @override
  void didUpdateWidget(MapPicker old) {
    super.didUpdateWidget(old);
    final value = widget.value;
    if (value != null && value != old.value && value != _lastPicked) {
      _follow(value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _follow(GeoPoint point) {
    if (!_ready) return; // initialCenter already covers the first frame
    _controller.move(
      _latLng(point),
      math.max(_controller.camera.zoom, _pointZoom),
    );
  }

  void _onTap(TapPosition _, LatLng latLng) {
    final point = GeoPoint(lat: latLng.latitude, long: latLng.longitude);
    _lastPicked = point;
    widget.onChanged(point);
  }

  static LatLng _latLng(GeoPoint p) => LatLng(p.lat, p.long);

  @override
  Widget build(BuildContext context) {
    final value = widget.value;
    final start = value ?? widget.initialCenter;
    return Semantics(
      label: 'Bản đồ chọn vị trí. Chạm để đặt vị trí.',
      value: value == null
          ? 'Chưa chọn'
          : '${value.lat.toStringAsFixed(5)}, ${value.long.toStringAsFixed(5)}',
      child: FlutterMap(
        mapController: _controller,
        options: MapOptions(
          initialCenter: start == null ? _vietnam : _latLng(start),
          initialZoom: start == null ? _countryZoom : _pointZoom,
          onTap: _onTap,
          onMapReady: () => _ready = true,
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: Env.mapTileUrl,
            userAgentPackageName: _userAgentPackageName,
          ),
          if (value != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _latLng(value),
                  width: _markerSize,
                  height: _markerSize,
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.location_on,
                    size: _markerSize,
                    color: context.scheme.primary,
                  ),
                ),
              ],
            ),
          const SimpleAttributionWidget(
            source: Text('OpenStreetMap contributors'),
          ),
        ],
      ),
    );
  }
}
