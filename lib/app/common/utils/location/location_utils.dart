import 'dart:math';
import 'package:geolocator/geolocator.dart';

class LocationUtils {
  static Future<double> getDistanceFromCurrentLocation(
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    // Get current location
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return calculateDistance(position.latitude, position.longitude,
        destinationLatitude, destinationLongitude);
  }

  static double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    const double earthRadius = 6371;

    double latDiff = _toRadians(endLatitude - startLatitude);
    double lonDiff = _toRadians(endLongitude - startLongitude);

    double a = sin(latDiff / 2) * sin(latDiff / 2) +
        cos(_toRadians(startLatitude)) *
            cos(_toRadians(endLatitude)) *
            sin(lonDiff / 2) *
            sin(lonDiff / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  static double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
