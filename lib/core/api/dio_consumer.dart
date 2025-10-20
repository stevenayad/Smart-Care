import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/faluire.dart';

import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio) {
    dio.options
      ..baseUrl = 'https://smartcarepharmacy.tryasp.net/api/'
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 15)
      ..headers = {
        'Accept': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjA2YWVkMmMyLWFmNWMtNDBhZi1iYjlkLTdiZDM2NmY0ODA0MyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6InN0ZXZlbmF5YWQ5QGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJTb3N0YSIsImV4cCI6MTc2MDc1NzAzNCwiaXNzIjoiU21hcnRDYXJlIEFQSSBTZXJ2aWNlIiwiYXVkIjoiRmx1dHRlciBNb2JpbGUgQXBwbGljYXRpb24ifQ.hoDLexB18aaNN6uz3vPTyv7c248TWAV-yuPMMMRae7Y',
      };
  }

  Future<Either<Failure, dynamic>> get(
    String endpoint,
    Map<String, dynamic>? query,
  ) async {
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
