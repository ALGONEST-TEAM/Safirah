import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Geographic delivery coverage for Yemen.
///
/// Bounds are defined by the northern, southern, eastern, and western edges:
/// - North: 19.00°N, 43.00°E
/// - South: 12.00°N, 43.00°E
/// - East:  15.00°N, 54.60°E
/// - West:  15.00°N, 42.50°E
abstract final class YemenDeliveryBounds {
  static const double minLatitude = 12.0;
  static const double maxLatitude = 19.0;
  static const double minLongitude = 42.5;
  static const double maxLongitude = 54.6;

  static bool contains({
    required double latitude,
    required double longitude,
  }) {
    return latitude >= minLatitude &&
        latitude <= maxLatitude &&
        longitude >= minLongitude &&
        longitude <= maxLongitude;
  }

  static bool containsLatLng(LatLng location) {
    return contains(
      latitude: location.latitude,
      longitude: location.longitude,
    );
  }
}
