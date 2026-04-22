import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// 🔐 Check + Request Permission
Future<bool> checkLocationPermission() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return false;
  }

  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever ||
      permission == LocationPermission.denied) {
    return false;
  }

  return true;
}

/// 📍 Get current location safely
Future<Position?> getLocation() async {
  final hasPermission = await checkLocationPermission();

  if (!hasPermission) return null;

  try {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  } catch (e) {
    return null;
  }
}

/// 🌍 Detect country safely
Future<String?> detectCountry() async {
  final position = await getLocation();

  if (position == null) return null;

  try {
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
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
    print("Country ${response.data['country_code']}");
    return response.data['country_code']; // زي EG / US
  } catch (e) {
    return null;
  }
}
