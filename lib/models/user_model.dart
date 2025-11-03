// NEW FILE: lib/models/user_model.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluxxy/common/tools/ui_feedback.dart';

import '../services/api/api_service.dart';
import 'entities/user.dart';
import '../services/user_service.dart';

/// مطابق لروح Fluxstore: موديل حالة يمسك الـ User وحالة الدخول/التحميل.
/// مبدئيًا بيجسر على UserService الحالي لحين الانتقال الكامل.
class UserModel extends ChangeNotifier {
  User? _user;
  bool _loggedIn = false;
  bool _loading = false;

  User? get user => _user;
  bool get loggedIn => _loggedIn;
  bool get loading => _loading;

  Future<void> loadFromStorage() async {
    _user = await UserService.loadUserFromStorage();
    _loggedIn = _user != null;
    notifyListeners();
  }

  /// 🔹 تسجيل الدخول الحقيقي عبر API
  Future<bool> login(BuildContext context, String email, String password, {String? name}) async {
    _loading = true;
    notifyListeners();

    try {
      final response = await ApiService.login(email, password);
      if (response != null && response.statusCode == 200) {
        final data = response.data;
        final userData = data['user'] ?? data;
        final token = data['token'] ?? '';

        _user = User(
          id: userData['id'] ?? '',
          name: userData['name'] ?? name ?? '',
          email: userData['email'] ?? email,
          token: token,
        );

        _loggedIn = true;
        await UserService.saveUserToStorage(_user!);
        notifyListeners();

        UIFeedback.showSuccess(context, 'Welcome back, ${_user!.name} 👋');
        return true;
      } else {
        UIFeedback.showError(context, 'Login failed. Please check your credentials.');
      }
    } on DioError catch (e) {
      final status = e.response?.statusCode;
      final msg = e.response?.data?['message'];

      if (status == 401) {
        UIFeedback.showError(context, msg ?? 'Invalid email or password.');
      } else if (status == 500) {
        UIFeedback.showError(context, 'Server error. Please try again later.');
      } else {
        UIFeedback.showError(
          context,
          msg ?? 'Unable to log in. Please check your connection.',
        );
      }
    } catch (e) {
      UIFeedback.showError(context, 'Unexpected error: $e');
    }

    _loading = false;
    notifyListeners();
    return false;
  }

  /// 🔹 تسجيل مستخدم جديد عبر API
  /// 🔹 تسجيل مستخدم جديد عبر API مع عرض رسائل الخطأ أو النجاح
  Future<bool> register(
    BuildContext context,
    String name,
    String email,
    String password,
  ) async {
    _loading = true;
    notifyListeners();

    try {
      final response = await ApiService.register(name, email, password);

      if (response != null && response.statusCode == 200) {
        final data = response.data;
        final token = data['token'] ?? '';
        final userData = data['user'] ?? data;

        _user = User(
          id: userData['id']?.toString() ?? '',
          name: userData['name'] ?? name,
          email: userData['email'] ?? email,
          token: token,
        );

        _loggedIn = true;
        await UserService.saveUserToStorage(_user!);
        notifyListeners();

        UIFeedback.showSuccess(context, 'Registration successful 🎉');
        return true;
      } else {
        UIFeedback.showError(context, 'Registration failed. Please try again.');
      }
    } on DioError catch (e) {
      final msg = e.response?.data?['message'] ??
          'Could not complete registration. Please try again.';
      UIFeedback.showError(context, msg);
    } catch (e) {
      UIFeedback.showError(context, 'Unexpected error: $e');
    }

    _loading = false;
    notifyListeners();
    return false;
  }

  /// 🔹 تسجيل خروج المستخدم
  Future<void> logout() async {
    _user = null;
    _loggedIn = false;
    await UserService.clearUserData();
    notifyListeners();
  }
}
