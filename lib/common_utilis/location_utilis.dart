import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationUtils {
  // Utility function to fetch current lat, long and convert to address
  static Future<Map<String, dynamic>?> getCurrentLocationAndAddress() async {
    try {
      // Step 1: Check location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("Location services are disabled.");
        return null;
      }

      // Step 2: Check and request location permission
      PermissionStatus permission = await Permission.location.status;
      if (permission.isDenied) {
        permission = await Permission.location.request();
        if (permission.isDenied) {
          print("Location permission denied.");
          return null;
        }
      }
      if (permission.isPermanentlyDenied) {
        print("Location permission permanently denied.");
        await openAppSettings();
        return null;
      }

      // Step 3: Fetch the current position (latitude, longitude)
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Step 4: Convert the lat/long to an address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      String address = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

      // Step 5: Return lat, long, and address
      return {
        "latitude": position.latitude,
        "longitude": position.longitude,
        "address": address,
      };
    } catch (e) {
      print("Error occurred while fetching location or address: $e");
      return null;
    }
  }
}
