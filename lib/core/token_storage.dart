import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// [TokenStorage] handles secure storage of authentication tokens and their expiry dates.
/// It is implemented as a Singleton to ensure consistency across the app.
class TokenStorage {
  static final TokenStorage _instance = TokenStorage._internal();
  factory TokenStorage() => _instance;
  TokenStorage._internal();

  final _storage = const FlutterSecureStorage();

  static const _keyAccess = 'access_token';
  static const _keyRefresh = 'refresh_token';
  static const _keyAccessExpires = 'access_token_expires_at';
  static const _keyRefreshExpires = 'refresh_token_expires_at';

  /// Saves tokens and parses expiry dates correctly.
  Future<void> saveTokens({
    required String access,
    required String refresh,
    required String accessExpires,
    required String refreshExpires,
  }) async {
    await _storage.write(key: _keyAccess, value: access);
    await _storage.write(key: _keyRefresh, value: refresh);

    // Always parse token expiry values correctly using DateTime.parse
    // and store them as ISO8601 strings for consistency.
    await _storage.write(
      key: _keyAccessExpires,
      value: DateTime.parse(accessExpires).toIso8601String(),
    );
    await _storage.write(
      key: _keyRefreshExpires,
      value: DateTime.parse(refreshExpires).toIso8601String(),
    );
  }

  Future<String?> getAccessToken() async =>
      await _storage.read(key: _keyAccess);
  Future<String?> getRefreshToken() async =>
      await _storage.read(key: _keyRefresh);

  Future<DateTime?> getAccessTokenExpiresAt() async {
    final expiry = await _storage.read(key: _keyAccessExpires);
    return expiry != null ? DateTime.tryParse(expiry) : null;
  }

  Future<DateTime?> getRefreshTokenExpiresAt() async {
    final expiry = await _storage.read(key: _keyRefreshExpires);
    return expiry != null ? DateTime.tryParse(expiry) : null;
  }

  /// Checks if the access token is expired or will expire within the given [buffer].
  Future<bool> isAccessTokenExpired({
    Duration buffer = const Duration(seconds: 30),
  }) async {
    final expiry = await getAccessTokenExpiresAt();
    if (expiry == null) return true;
    return DateTime.now().isAfter(expiry.subtract(buffer));
  }

  /// Checks if the refresh token is expired.
  Future<bool> isRefreshTokenExpired() async {
    final expiry = await getRefreshTokenExpiresAt();
    if (expiry == null) return true;
    return DateTime.now().isAfter(expiry);
  }

  /// Clears all stored tokens.
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
