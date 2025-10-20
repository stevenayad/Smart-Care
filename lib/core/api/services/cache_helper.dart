
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  static const String _accessTokenKey = 'accessToken';
  static const String _userIdKey = 'userId';

  
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveAccessToken(String token) async {
    await _sharedPreferences.setString(_accessTokenKey, token);
  }

  static String? getAccessToken() {
    return _sharedPreferences.getString(_accessTokenKey);
  }

  static Future<void> saveUserId(String userId) async {
    await _sharedPreferences.setString(_userIdKey, userId);
  }

  static String? getUserId() {
    return _sharedPreferences.getString(_userIdKey);
  }

  static Future<void> clearAll() async {
    await _sharedPreferences.clear();
  }
}