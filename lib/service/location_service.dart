import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  // request location
  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.request();
    return status.isGranted;
  }

  //  check if the location Granted
  Future<bool> isLocationPermissionGranted() async {
    return await Permission.location.isGranted;
  }

  // check if the service is active
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // get the current location
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null; //location service not active
    }

    bool permissionGranted = await isLocationPermissionGranted();
    if (!permissionGranted) {
      return null; // not granted
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
