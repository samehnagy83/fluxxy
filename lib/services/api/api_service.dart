import 'package:dio/dio.dart';
import 'request.dart';
import 'endpoints.dart';

class ApiService {
  static Future<Response?> login(String email, String password) async {
    return await Request.post(Endpoints.login, data: {
      'email': email,
      'password': password,
    });
  }

  static Future<Response?> register(
      String name, String email, String password) async {
    return await Request.post(Endpoints.register, data: {
      'name': name,
      'email': email,
      'password': password,
    });
  }

  static Future<Response?> forgotPassword(String email) async {
    return await Request.post(Endpoints.forgotPassword, data: {
      'email': email,
    });
  }
}
