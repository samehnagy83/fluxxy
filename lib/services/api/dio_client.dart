import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://example.com/api/', // غيّرها بالرابط الحقيقي لاحقاً
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  )..interceptors.add(ApiInterceptor()); // 🧩 نضيف الـ Interceptor هنا

  static Dio get instance => _dio;
}

/// 🧩 Interceptor مخصص للتعامل مع الطلبات والأخطاء
class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('➡️ [REQUEST] ${options.method} ${options.uri}');
    if (options.data != null) {
      print('📦 Data: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('✅ [RESPONSE] ${response.statusCode} ${response.requestOptions.uri}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('❌ [ERROR] ${err.response?.statusCode} ${err.requestOptions.uri}');
    if (err.response != null) {
      print('💬 Message: ${err.response?.data}');
    } else {
      print('⚠️ Error: ${err.message}');
    }
    super.onError(err, handler);
  }
}
