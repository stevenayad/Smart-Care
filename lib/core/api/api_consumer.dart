import 'package:dio/src/dio.dart';

abstract class ApiConsumer {
  ApiConsumer(Dio dio);

  Future<dynamic> get(String endpoint,Map<String,dynamic>? query);
  Future<dynamic> post(
    String endpoint,
    dynamic body,
    bool isFormData,
  ); //changed body to dynamic to accept form data
  Future<dynamic> put(String endpoint, Map<String, dynamic>? body);
  Future<dynamic> delete(String endpoint, Map<String, dynamic>? body);
}
