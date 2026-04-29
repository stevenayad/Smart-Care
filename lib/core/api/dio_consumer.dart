import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:smartcare/core/api/dio_interceptors.dart';
import 'package:smartcare/core/token_storage.dart';
import 'api_consumer.dart';

/// [DioConsumer] is the implementation of [ApiConsumer] using the Dio library.
/// It configures base options and attaches the authentication interceptor.
class DioConsumer implements ApiConsumer {
  final Dio dio;
  final TokenStorage storage = TokenStorage(); // Singleton
  VoidCallback? onUnauthorized;
  Function(String)? onTokenRefreshed;

  DioConsumer(this.dio) {
    dio.options = BaseOptions(
      baseUrl: 'https://smartcarepharmacy.tryasp.net/',
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
    );

    // Attach the Singleton Interceptor
    // This handles: Proactive refresh, 401 handling, and Header injection.
    dio.interceptors.add(
      InterceptorsConsumer(
        dio: dio,
        onUnauthorized: () => onUnauthorized?.call(),
        onTokenRefreshed: (token) => onTokenRefreshed?.call(token),
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          logPrint: (obj) {
            final log = obj.toString();
            if (log.length > 1000) {
              print('🪵 DioLog (truncated): ${log.substring(0, 1000)}...');
            } else {
              print('🪵 DioLog: $log');
            }
          },
        ),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // GET
  // ---------------------------------------------------------------------------
  @override
  Future<dynamic> get(String endpoint, Map<String, dynamic>? query) async {
    try {
      // ✅ CLEANUP: Removed manual token injection. Interceptor handles it.
      print('📡 GET => ${dio.options.baseUrl}$endpoint');

      final response = await dio.get(endpoint, queryParameters: query);

      return response.data;
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      rethrow;
    } catch (e) {
      print("🔥 Non-Dio Error: $e");
      rethrow;
    }
  }

  // ---------------------------------------------------------------------------
  // POST
  // ---------------------------------------------------------------------------
  @override
  Future<dynamic> post(String endpoint, dynamic body, bool isFormData) async {
    try {
      print('📤 POST => ${dio.options.baseUrl}$endpoint');

      final response = await dio.post(endpoint, data: body);

      return response.data;
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      rethrow;
    } catch (e) {
      print("🔥 Non-Dio Error: $e");
      rethrow;
    }
  }

  // ---------------------------------------------------------------------------
  // PUT
  // ---------------------------------------------------------------------------
  @override
  Future<dynamic> put(
    String endpoint,
    dynamic body, {
    bool isFormData = false,
  }) async {
    try {
      print('📝 PUT => ${dio.options.baseUrl}$endpoint');

      final response = await dio.put(endpoint, data: body);

      return response.data;
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      rethrow;
    } catch (e) {
      print("🔥 Non-Dio Error: $e");
      rethrow;
    }
  }

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------
  @override
  Future<dynamic> delete(String endpoint, Map<String, dynamic>? body) async {
    try {
      print('🗑️ DELETE => ${dio.options.baseUrl}$endpoint');

      final response = await dio.delete(endpoint, data: body);

      return response.data;
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      rethrow;
    } catch (e) {
      print("🔥 Non-Dio Error: $e");
      rethrow;
    }
  }

  @override
  Future<dynamic> patch(String endpoint, Map<String, dynamic>? body) async {
    try {
      print('🛠️ PATCH => ${dio.options.baseUrl}$endpoint');

      final response = await dio.patch(endpoint, data: body);

      return response.data;
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      rethrow;
    } catch (e) {
      print("🔥 Non-Dio Error: $e");
      rethrow;
    }
  }
}
