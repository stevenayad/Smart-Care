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
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjdhZjQyZGQ5LTk4OTgtNDEzZi1hYzQ5LThkYWE1MTRlZmYxNyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImF5YWR3YXNlZjE4M0BnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiQW5kQUxMTCIsImV4cCI6MTc2MDcyOTU4MSwiaXNzIjoiU21hcnRDYXJlIEFQSSBTZXJ2aWNlIiwiYXVkIjoiRmx1dHRlciBNb2JpbGUgQXBwbGljYXRpb24ifQ.B9TuVUEzADA6G1xLkL410LTXf00zFgYT5-ehbUWdP3o',
      };
  }

  Future<Either<Failure, dynamic>> get(
    String endpoint,
    Map<String, dynamic>? query,
  ) async {
    try {
      final response = await dio.get(endpoint, queryParameters: query);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  @override
  Future<dynamic> post(String endpoint, dynamic body, bool isFormData) async {
    // try {
    //   final response = await dio.post(
    //     endpoint,
    //     data: isFormData ? FormData.fromMap(body!) : body,
    //   );
    //   return response.data;
    // }
    try {
      if (isFormData) {
        dio.options.headers.remove('Content-Type');
      } else {
        dio.options.headers['Content-Type'] = 'application/json';
      }

      final response = await dio.post(endpoint, data: body);
      return response.data;
    } on Exception catch (e) {
      if (e is DioException) {
        return servivefailure.fromDioError(e);
      } else {
        return servivefailure(e.toString());
      }
    }
  }

  @override
  Future<dynamic> put(String endpoint, Map<String, dynamic>? body) async {
    try {
      final response = await dio.put(endpoint, data: body);
      return response.data;
    } on Exception catch (e) {
      if (e is DioException) {
        return servivefailure.fromDioError(e);
      } else {
        return servivefailure(e.toString());
      }
    }
  }

  @override
  Future<dynamic> delete(String endpoint, Map<String, dynamic>? body) async {
    try {
      final response = await dio.delete(endpoint, data: body);
      return response.data;
    } on Exception catch (e) {
      if (e is DioException) {
        return servivefailure.fromDioError(e);
      } else {
        return servivefailure(e.toString());
      }
    }
  }
}
