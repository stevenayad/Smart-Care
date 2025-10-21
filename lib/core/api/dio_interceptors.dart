import 'package:dio/dio.dart';

class InterceptorsConsumer extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Before the request is sent
    print('➡️ REQUEST[${options.method}] => PATH: ${options.path}');
    
    // Example: add headers or tokens
    options.headers['Authorization'] = 'Bearer your_token_here';
    
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // When a response is received
    print('✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // When an error occurs
    print('❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print('Message: ${err.message}');
    
    // Example: handle token expiration
    if (err.response?.statusCode == 401) {
      print('Token expired! Handle refresh here.');
    }

    super.onError(err, handler);
  }
}
