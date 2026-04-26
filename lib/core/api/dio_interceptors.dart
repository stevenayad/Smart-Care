import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:smartcare/core/token_storage.dart';

/// [InterceptorsConsumer] handles authentication headers, proactive token refresh,
/// 401 retries, and concurrency control for token renewal.
class InterceptorsConsumer extends Interceptor {
  final Dio dio;
  final TokenStorage storage = TokenStorage(); // Singleton
  final VoidCallback onUnauthorized;
  final Function(String)? onTokenRefreshed;

  InterceptorsConsumer({
    required this.dio,
    required this.onUnauthorized,
    this.onTokenRefreshed,
  });

  /// Completer to handle concurrent refresh calls.
  /// Only one refresh request will be made at a time.
  Completer<String?>? _refreshCompleter;

  /// Guard to ensure logout logic (e.g., navigation) only happens once.
  bool _isLoggingOut = false;

  void _safeLogout() async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;
    
    await storage.clear();
    onUnauthorized();
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip intercepting login and refresh-token endpoints.
    if (options.path.contains('/login') ||
        options.path.contains('/refresh-token') ||
        options.path.contains('/sign-up')) {
      return handler.next(options);
    }

    // 1. Proactive Refresh Logic: Check if token is expired (or nearly expired) BEFORE request.
    final isExpired = await storage.isAccessTokenExpired();
    
    if (isExpired) {
      print("🕒 Token expired or near expiry → Proactive refresh starting");
      
      final newToken = await _refreshToken();

      if (newToken != null) {
        options.headers['Authorization'] = 'Bearer $newToken';
        return handler.next(options);
      } else {
        // If refresh failed, reject the request and logout.
        _safeLogout();
        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'Session expired',
            type: DioExceptionType.cancel,
          ),
        );
      }
    }

    // 2. Normal Request: Attach Authorization header if token exists.
    final token = await storage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 3. Reactive Refresh: Handle 401 Unauthorized errors.
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains('/login') &&
        !err.requestOptions.path.contains('/refresh-token')) {
      
      print("❌ 401 Unauthorized → Attempting reactive refresh");

      final newToken = await _refreshToken();

      if (newToken != null) {
        // Retry the failed request with the new token.
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $newToken';

        try {
          final response = await dio.fetch(options);
          return handler.resolve(response);
        } on DioException catch (retryError) {
          return handler.next(retryError);
        }
      } else {
        _safeLogout();
      }
    }

    return handler.next(err);
  }

  /// Refreshes the access token with concurrency control.
  Future<String?> _refreshToken() async {
    // ✅ Concurrency Control: Avoid multiple refresh calls at the same time.
    if (_refreshCompleter != null && !_refreshCompleter!.isCompleted) {
      print("⏳ Refresh already in progress → waiting for result");
      return _refreshCompleter!.future;
    }

    _refreshCompleter = Completer<String?>();

    try {
      // ✅ Guard: If refresh token itself is expired, clear storage and logout.
      if (await storage.isRefreshTokenExpired()) {
        print("🚨 Refresh Token expired → Permanent logout");
        _refreshCompleter!.complete(null);
        return null;
      }

      final access = await storage.getAccessToken();
      final refresh = await storage.getRefreshToken();

      if (refresh == null || refresh.isEmpty) {
        _refreshCompleter!.complete(null);
        return null;
      }

      // Use a clean Dio instance or the same one but ensure no interceptor loop.
      // Since we skip '/refresh-token' in onRequest, we can use the same dio instance.
      final response = await dio.post(
        '/api/auth/refresh-token',
        data: {'accessToken': access, 'refreshToken': refresh},
      );

      if (response.statusCode == 200 && response.data['succeeded'] == true) {
        final data = response.data['data'];

        final newAccess = data['accessToken'];
        final newRefresh = data['refreshToken'];
        final newAccessExpiry = data['accessTokenExpiresAt'];
        final newRefreshExpiry = data['refreshTokenExpiresAt'];

        // Always parse token expiry values correctly using DateTime.parse (handled in TokenStorage)
        await storage.saveTokens(
          access: newAccess,
          refresh: newRefresh,
          accessExpires: newAccessExpiry,
          refreshExpires: newRefreshExpiry,
        );

        print("✅ Token refreshed successfully");

        // Notify that the token was refreshed (e.g., for SignalR update)
        onTokenRefreshed?.call(newAccess);

        _refreshCompleter!.complete(newAccess);
        return newAccess;
      } else {
        print("⚠️ Refresh failed: Invalid response");
        _refreshCompleter!.complete(null);
        return null;
      }
    } catch (e) {
      // Handle all edge cases: Network failure during refresh, invalid tokens, etc.
      print("🔥 Refresh Error (Network/Server): $e");
      _refreshCompleter!.complete(null);
      return null;
    }
  }
}
