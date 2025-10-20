import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/failure.dart';

import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio) {
    dio.options
      ..baseUrl = 'https://smartcarepharmacy.tryasp.net'
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 20)
      ..headers = {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
  }

  @override
  Future<dynamic> get(String endpoint, Map<String, dynamic>? query) async {
    try {
      final response = await dio.get(endpoint, queryParameters: query);
      return response.data;
    } on DioError catch (e) {
      throw e;
    } catch (e) {
      throw Exception(e.toString());
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
      throw e;
    } catch (e) {

      throw Exception(e.toString());
      
    }
  }

  @override
  Future<dynamic> put(String endpoint, Map<String, dynamic>? body) async {
    try {
      final response = await dio.put(endpoint, data: body);
      return response.data;
    }on DioError catch (e) {
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
