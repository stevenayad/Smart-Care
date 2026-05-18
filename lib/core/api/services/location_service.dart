import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' hide LocationAccuracy;


class LocationServiceGelcator {
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}

class LocationServices {
  static Location location = Location();

 static Future<bool> CheckAndRequestLocationServices() async {
    var ServiceEnbled = await location.serviceEnabled();
    if (!ServiceEnbled) {
      bool ServiceEnbled = await location.requestService();
      if (!ServiceEnbled) {
        return false;
      }
    }
    return true;
  }

  static Future<bool> CheckAndRequestLocationPermission() async {
    var permsissionStatus = await location.hasPermission();

    if (permsissionStatus == PermissionStatus.deniedForever) {
      return false;
    }

    if (permsissionStatus == PermissionStatus.denied) {
      var permsissionStatus = await location.requestPermission();
      return (permsissionStatus == PermissionStatus.granted);
    }
    return true;
  }

  static Future<LocationData> getlocationData() async {
    CheckAndRequestLocationServices();
    CheckAndRequestLocationPermission();
    return await location.getLocation();
  }
}