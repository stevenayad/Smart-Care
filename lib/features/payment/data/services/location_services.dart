import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' hide Location;

/// 🔐 Check + Request Permission
Future<bool> checkLocationPermission() async {
  Location location = Location();

  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return false;
    }
  }

  PermissionStatus permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return false;
    }
  }

  if (permissionGranted == PermissionStatus.deniedForever) {
    return false;
  }

  return true;
}

/// 📍 Get current location safely
Future<LocationData?> getLocation() async {
  final hasPermission = await checkLocationPermission();

  if (!hasPermission) return null;

  try {
    Location location = Location();
    return await location.getLocation();
  } catch (e) {
    return null;
  }
}

/// 🌍 Detect country safely
Future<String?> detectCountry() async {
  final locationData = await getLocation();

  if (locationData == null ||
      locationData.latitude == null ||
      locationData.longitude == null)
    return null;

  try {
    final placemarks = await placemarkFromCoordinates(
      locationData.latitude!,
      locationData.longitude!,
    );
    print("Country ${placemarks.first.isoCountryCode}");
    return placemarks.first.isoCountryCode;
  } catch (e) {
    return null;
  }
}

Future<String?> detectCountryByIP() async {
 try {
  print('Being Request For Detect Country');

  final response = await Dio().get('https://ipapi.co/json/');

  print(response.data.runtimeType);
  print("Country ${response.data['country_code']}");

  return response.data['country_code'];

} on DioException catch (e) {
  print("❌ Dio Error: ${e.message}");

  if (e.response != null) {
    print("Status Code: ${e.response?.statusCode}");
    print("Response Data: ${e.response?.data}");
  }

  return null;

} catch (e) {
  print("❌ Unknown Error: $e");
  return null;
}
}
