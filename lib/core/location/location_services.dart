import 'package:location/location.dart';

class LocationServices {
  Location location = Location();
  bool isPermissionGranted = false;

  Future<bool> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        return false;
      }
    }
    return true;
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      return permissionStatus == PermissionStatus.granted;
    }

    isPermissionGranted = permissionStatus == PermissionStatus.granted;
    return true;
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) {
    location.changeSettings(
        accuracy: LocationAccuracy.high, interval: 1000, distanceFilter: 100);
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLocation() async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    return await location.getLocation();
  }

  getPlacemarkFromCoordinates(double d, double e) {}
}

class LocationServiceException implements Exception {}

class LocationPermissionException implements Exception {}