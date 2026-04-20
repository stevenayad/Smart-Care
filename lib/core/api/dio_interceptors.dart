import 'package:dio/dio.dart';
import 'package:smartcare/core/token_storage.dart';

class InterceptorsConsumer extends Interceptor {
  final Dio dio;
  final TokenStorage storage;

  bool isRefreshing = false;

  InterceptorsConsumer({
    required this.dio,
    required this.storage,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await storage.getAccessToken();

    print("🧩 Access Token: $token");


    if (token != null &&
        token.isNotEmpty &&
        !options.path.contains('/login') &&
        !options.path.contains('/refresh-token')) {
      options.headers['Authorization'] = 'Bearer $token';
      print("✅ Token Attached");
    }

    return handler.next(options); 
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print("❌ Error: ${err.response?.statusCode}");

 
    if (err.response?.statusCode == 401 && !isRefreshing) {
      isRefreshing = true;

      final refreshToken = await storage.getRefreshToken();
      final accessToken = await storage.getAccessToken();

      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          final response = await dio.post(
            '/api/auth/refresh-token',
            data: {
              'accessToken': accessToken,
              'refreshToken': refreshToken,
            },
          );

          final newAccess = response.data['accessToken'];
          final newRefresh = response.data['refreshToken'];

          await storage.saveTokens(
            access: newAccess,
            refresh: newRefresh,
          );

          isRefreshing = false;

          /// 🔁 إعادة نفس الريكوست
          final requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] = 'Bearer $newAccess';

          final cloneResponse = await dio.fetch(requestOptions);

          return handler.resolve(cloneResponse); 
        } catch (e) {
          isRefreshing = false;

          await storage.clear(); // logout

          return handler.reject(err); 
        }
      }
    }

    return handler.next(err);
  }
}