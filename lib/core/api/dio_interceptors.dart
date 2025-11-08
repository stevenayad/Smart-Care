import 'package:dio/dio.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';

class InterceptorsConsumer extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = CacheHelper.getAccessToken();
    print("🧩 Access Token from Cache: $token");
    final userId = CacheHelper.getUserId();
    print("🧩 ID from Cache: $userId");

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      print("✅ Token Attached");
    } else {
      print("❌ Token Missing");
    }

    print('''
➡️ [REQUEST] -------------------------------
METHOD: ${options.method}
URL: ${options.uri}
HEADERS: ${options.headers}
DATA: ${options.data}
QUERY: ${options.queryParameters}
PATH: ${options.path}
--------------------------------------------
''');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('''
✅ [RESPONSE] -------------------------------
STATUS: ${response.statusCode}
URL: ${response.requestOptions.uri}
DATA: ${response.data}
--------------------------------------------
''');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('''
❌ [ERROR] ---------------------------------
STATUS: ${err.response?.statusCode}
URL: ${err.requestOptions.uri}
MESSAGE: ${err.message}
DATA: ${err.response?.data}
--------------------------------------------
''');
    if (err.response?.statusCode == 401) {
      print('Token expired! Handle refresh here.');
    }

    super.onError(err, handler);
  }
}