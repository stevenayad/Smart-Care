import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:smartcare/core/api/dio_interceptors.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/core/faluire.dart';

import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio) {
    dio
      ..options = BaseOptions(
        baseUrl: 'https://smartcarepharmacy.tryasp.net/',
        connectTimeout: const Duration(seconds: 60),
      );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (obj) => print('🪵 DioLog: $obj'),
      ),
    );

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };
    /*dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) async {
      print("🧩 Interceptor triggered...");
      final token =  CacheHelper.getAccessToken();
      print("🧩 Token retrieved: $token");
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
  ),
);*/
  }
  @override
  Future<dynamic> get(String endpoint) async {
    print("innnnnnnnnnnnnnn");

    try {
      print('outttttttttttttttttttttt');
      print("Cache halper ==>>>${CacheHelper.getAccessToken()}");
      print('📡 GET URL => ${dio.options.baseUrl}$endpoint');

      final response = await dio.get(
        endpoint,
        options: Options(
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
          headers: {
            'Authorization': 'Bearer ${CacheHelper.getAccessToken()}',
            'Accept': 'application/json',
          },
        ),
      );

      print("✅ Dio Success: ${response.statusCode}");
      print("🔵 RAW RESPONSE: ${response.data}");
      print("✅ Dio Data Type: ${response.data.runtimeType}");
      return response.data;
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      if (e.response != null) {
        print("❌ Response data: ${e.response?.data}");
      }
      rethrow;
    } catch (e, s) {
      print("🔥 Non-Dio Error: $e");
      print(s);
      return {'error': e.toString()};
    }
  }

  @override
  Future<dynamic> post(String endpoint, dynamic body, bool isFormData) async {
    try {
      if (isFormData) {
        dio.options.headers.remove('Content-Type');
      } else {
        dio.options.headers['Content-Type'] = 'application/json';
      }

      final response = await dio.post(endpoint, data: body);
      return response.data;
    } on DioError catch (e) {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<dynamic> put(String endpoint, Map<String, dynamic>? body) async {
    try {
      final response = await dio.put(endpoint, data: body);
      return response.data;
    } on DioError catch (e) {
      throw e;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<dynamic> delete(String endpoint, Map<String, dynamic>? body) async {
    try {
      final response = await dio.delete(endpoint, data: body);
      return response.data;
    } on DioError catch (e) {
      throw e;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
