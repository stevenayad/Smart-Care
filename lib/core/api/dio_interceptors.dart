import 'dart:async';

import 'package:dio/dio.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';

class InterceptorsConsumer extends Interceptor {
  final Dio dio;

  InterceptorsConsumer({required this.dio});
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

   /* print('''
➡️ [REQUEST] -------------------------------
METHOD: ${options.method}
URL: ${options.uri}
HEADERS: ${options.headers}
DATA: ${options.data}
QUERY: ${options.queryParameters}
PATH: ${options.path}
--------------------------------------------
''');*/

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
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await CacheHelper.getRefreashToken();
        final accessToken = await CacheHelper.getAccessToken();

        if (refreshToken == null) {
          return handler.next(err);
        }

        // نطلب تحديث التوكن
        final res = await Dio().post(
          "https://smartcarepharmacy.tryasp.net/api/auth/refresh-token",
          data: {"accessToken": accessToken, "refreshToken": refreshToken},
        );

        final newAccess = res.data['data']["accessToken"];
        final newRefresh = res.data['data']["refreshToken"];

        await CacheHelper.saveAccessToken(newAccess);
        await CacheHelper.saveRefreashToken(newRefresh);

        final newResponse = await _retryRequest(err.requestOptions);

        return handler.resolve(newResponse);
      } catch (e) {
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    final newToken = await CacheHelper.getAccessToken();

    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: {
          ...requestOptions.headers,
          "Authorization": "Bearer $newToken",
        },
      ),
    );
  }
}
