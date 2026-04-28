import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:smartcare/core/token_storage.dart';

class InterceptorsConsumer extends Interceptor {
  final Dio dio;
  final TokenStorage storage = TokenStorage();
  final VoidCallback onUnauthorized;
  final Function(String)? onTokenRefreshed;

  InterceptorsConsumer({
    required this.dio,
    required this.onUnauthorized,
    this.onTokenRefreshed,
  });

  Completer<String?>? _refreshCompleter;
  bool _isLoggingOut = false;

  void _safeLogout() async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;

    await storage.clear();
    onUnauthorized();
  }

  bool _isAuthEndpoint(String path) {
    return path.contains('/login') ||
        path.contains('/refresh-token') ||
        path.contains('/sign-up');
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isAuthEndpoint(options.path)) {
      return handler.next(options);
    }

    try {
      final isExpired = await storage.isAccessTokenExpired();

      // 🔥 Proactive Refresh
      if (isExpired) {
        debugPrint("🕒 Proactive refresh");

        final newToken = await _refreshToken();

        if (newToken == null) {
          _safeLogout();
          return handler.reject(
            DioException(
              requestOptions: options,
              error: 'Session expired',
              type: DioExceptionType.cancel,
            ),
          );
        }

        options.headers['Authorization'] = 'Bearer $newToken';
        return handler.next(options);
      }

      final token = await storage.getAccessToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      handler.next(options);
    } catch (e) {
      handler.next(options);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !_isAuthEndpoint(err.requestOptions.path)) {
      debugPrint("❌ 401 → Reactive refresh");

      final newToken = await _refreshToken();

      if (newToken != null) {
        final options = err.requestOptions;

        options.headers['Authorization'] = 'Bearer $newToken';

        try {
          final response = await dio.fetch(options);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      } else {
        _safeLogout();
      }
    }

    handler.next(err);
  }

  Future<String?> _refreshToken() async {
    if (_refreshCompleter != null && !_refreshCompleter!.isCompleted) {
      debugPrint("⏳ Waiting for refresh...");
      return _refreshCompleter!.future;
    }

    _refreshCompleter = Completer<String?>();

    try {
      if (await storage.isRefreshTokenExpired()) {
        debugPrint("🚨 Refresh token expired");
        _refreshCompleter!.complete(null);
        return null;
      }

      final access = await storage.getAccessToken();
      final refresh = await storage.getRefreshToken();

      if (refresh == null || refresh.isEmpty) {
        _refreshCompleter!.complete(null);
        return null;
      }

      final response = await dio.post(
        '/api/auth/refresh-token',
        data: {'accessToken': access, 'refreshToken': refresh},
      );

      if (response.statusCode == 200 && response.data['succeeded'] == true) {
        final data = response.data['data'];

        final newAccess = data['accessToken'];
        final newRefresh = data['refreshToken'];

        await storage.saveTokens(
          access: newAccess,
          refresh: newRefresh,
          accessExpires: data['accessTokenExpiresAt'],
          refreshExpires: data['refreshTokenExpiresAt'],
        );

        debugPrint("✅ Token refreshed");

        onTokenRefreshed?.call(newAccess);

        _refreshCompleter!.complete(newAccess);
        return newAccess;
      }

      _refreshCompleter!.complete(null);
      return null;
    } catch (e) {
      debugPrint("🔥 Refresh error: $e");
      _refreshCompleter!.complete(null);
      return null;
    }
  }
}
