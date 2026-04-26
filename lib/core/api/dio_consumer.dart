import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:smartcare/core/api/dio_interceptors.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/core/token_storage.dart';
import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;
  final storage = TokenStorage();
  DioConsumer(this.dio) {
    dio.options = BaseOptions(
      baseUrl: 'https://smartcarepharmacy.tryasp.net/',
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
    );

    dio.interceptors.add(InterceptorsConsumer(dio: dio, storage: storage));

    dio.interceptors.add(
      LogInterceptor(
        //request: true,
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

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };
  }

  // ---------------------------------------------------------------------------
  // GET
  // ---------------------------------------------------------------------------
  @override
  Future<dynamic> get(String endpoint, Map<String, dynamic>? query) async {
    try {
      final token = CacheHelper.getAccessToken();
      final headers = {'Accept': 'application/json'};
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      print('📡 GET => ${dio.options.baseUrl}$endpoint');
      print('🔵 Query Params: $query');
      print('🔑 Token: $token');

      final response = await dio.get(
        endpoint,
        queryParameters: query,
        options: Options(headers: headers),
      );

      print("✅ Dio Success: ${response.statusCode}");
      print("🔵 Response Data: ${response.data}");
      return response.data;
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      print("❌ Response: ${e.response?.data}");
      rethrow;
    } catch (e, s) {
      print("🔥 Non-Dio Error: $e");
      print(s);
      return {'error': e.toString()};
    }
  }

  // ---------------------------------------------------------------------------
  // POST
  // ---------------------------------------------------------------------------
  @override
  Future<dynamic> post(String endpoint, dynamic body, bool isFormData) async {
    try {
      final token = CacheHelper.getAccessToken();
      final headers = <String, String>{'Accept': 'application/json'};

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      if (isFormData) {
        headers.remove('Content-Type');
      } else {
        headers['Content-Type'] = 'application/json';
      }

      print('📤 POST => ${dio.options.baseUrl}$endpoint');
      print('📦 Body: $body');

      final response = await dio.post(
        endpoint,
        data: body,
        options: Options(headers: headers),
      );

      print("✅ Dio POST Success: ${response.statusCode}");
      print("🔵 Response: ${response.data}");
      return response.data;
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      print("❌ Response: ${e.response?.data}");
      rethrow;
    } catch (e, s) {
      print("🔥 Non-Dio Error: $e");
      print(s);
      return {'error': e.toString()};
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
      final token = CacheHelper.getAccessToken();
      final headers = <String, String>{'Accept': 'application/json'};

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      if (!isFormData) {
        headers['Content-Type'] = 'application/json';
      }

      print('📝 PUT => ${dio.options.baseUrl}$endpoint');
      print('📦 Body: $body');

      final response = await dio.put(
        endpoint,
        data: body,
        options: Options(headers: headers),
      );

      print("✅ Dio PUT Success: ${response.statusCode}");
      print("🔵 Response: ${response.data}");
      return response.data;
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      print("❌ Response: ${e.response?.data}");
      rethrow;
    } catch (e, s) {
      print("🔥 Non-Dio Error: $e");
      print(s);
      return {'error': e.toString()};
    }
  }

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------
  @override
  Future<dynamic> delete(String endpoint, Map<String, dynamic>? body) async {
    try {
      final token = CacheHelper.getAccessToken();
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      print('🗑️ DELETE => ${dio.options.baseUrl}$endpoint');
      print('📦 Body: $body');

      final response = await dio.delete(
        endpoint,
        data: body,
        options: Options(headers: headers),
      );

      print("✅ Dio DELETE Success: ${response.statusCode}");
      print("🔵 Response: ${response.data}");
      return response.data;
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      print("❌ Response: ${e.response?.data}");
      rethrow;
    } catch (e, s) {
      print("🔥 Non-Dio Error: $e");
      print(s);
      return {'error': e.toString()};
    }
  }

  @override
  Future<dynamic> patch(String endpoint, Map<String, dynamic>? body) async {
    try {
      final token = CacheHelper.getAccessToken();
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      print('🛠️ PATCH => ${dio.options.baseUrl}$endpoint');
      print('📦 Body: $body');

      final response = await dio.patch(
        endpoint,
        data: body,
        options: Options(headers: headers),
      );

      print("✅ Dio PATCH Success: ${response.statusCode}");
      print("🔵 Response: ${response.data}");
      return response.data;
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      print("❌ Response: ${e.response?.data}");
      rethrow;
    } catch (e, s) {
      print("🔥 Non-Dio Error: $e");
      print(s);
      return {'error': e.toString()};
    }
  }
}
