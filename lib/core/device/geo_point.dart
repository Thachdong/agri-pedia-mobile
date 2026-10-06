/// A WGS84 coordinate. Package-neutral so features never import
/// geolocator / latlong2 directly.
class GeoPoint {
  const GeoPoint({required this.lat, required this.long});

  final double lat;
  final double long;

  @override
  bool operator ==(Object other) =>
      other is GeoPoint && other.lat == lat && other.long == long;

  @override
  int get hashCode => Object.hash(lat, long);

  @override
  String toString() => 'GeoPoint($lat, $long)';
}
