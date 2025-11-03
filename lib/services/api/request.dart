import 'package:dio/dio.dart';
import 'dio_client.dart';

class Request {
  static Future<Response?> get(String url) async {
    try {
      return await DioClient.instance.get(url);
    } on DioError catch (e) {
      _handleError(e);
      return null;
    } catch (e) {
      print('GET error: $e');
      return null;
    }
  }

/*************  ✨ Windsurf Command ⭐  *************/
  /// ارسال طلب POST إلى خادم API مع بيانات optional.
  ///
  /// Returns a Future containing the response of the request.
  ///
  /// Throws a DioError if the request fails.
  ///
  /// Throws an exception if an unexpected error occurs.
/*******  6b6c6bfc-3328-4391-95da-27154c8c68a5  *******/  static Future<Response?> post(String url, {Map<String, dynamic>? data}) async {
    try {
      return await DioClient.instance.post(url, data: data);
    } on DioError catch (e) {
      _handleError(e);
      return null;
    } catch (e) {
      print('POST error: $e');
      return null;
    }
  }

  /// 🧠 دالة مساعدة لتحليل الأخطاء وإظهار رسائل مفهومة
  static String _handleError(DioError e) {
    String message = 'Unexpected error occurred';

    if (e.type == DioErrorType.connectionTimeout) {
      message = 'Connection timeout. Please check your internet.';
    } else if (e.type == DioErrorType.receiveTimeout) {
      message = 'Server response timeout.';
    } else if (e.type == DioErrorType.badResponse) {
      final statusCode = e.response?.statusCode ?? 0;
      final responseData = e.response?.data;

      switch (statusCode) {
        case 400:
          message = responseData['message'] ?? 'Bad request.';
          break;
        case 401:
          message = 'Unauthorized. Please log in again.';
          break;
        case 403:
          message = 'Access denied.';
          break;
        case 404:
          message = 'Requested resource not found.';
          break;
        case 500:
          message = 'Server error. Please try again later.';
          break;
        default:
          message = responseData?['message'] ?? 'Unknown server error.';
      }
    } else if (e.type == DioErrorType.unknown) {
      message = 'No internet connection or server unreachable.';
    }

    print('⚠️ API Error: $message');
    return message;
  }

}
