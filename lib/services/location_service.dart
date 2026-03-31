import 'package:geolocator/geolocator.dart';

class LocationService {
  static const double defaultLatitude = 40.7128;
  static const double defaultLongitude = -74.0060;

  Future<bool> requestPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final result = await Geolocator.requestPermission();
      return result == LocationPermission.whileInUse ||
          result == LocationPermission.always;
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Future<Position?> getCurrentLocation() async {
    try {
      final hasPermission = await requestPermission();
      if (!hasPermission) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  Future<Map<String, double>> getLocationCoordinates() async {
    try {
      final position = await getCurrentLocation();
      if (position != null) {
        return {'latitude': position.latitude, 'longitude': position.longitude};
      } else {
        // Return default coordinates if location unavailable
        return {'latitude': defaultLatitude, 'longitude': defaultLongitude};
      }
    } catch (e) {
      print('Error getting coordinates: $e');
      return {'latitude': defaultLatitude, 'longitude': defaultLongitude};
    }
  }
}
