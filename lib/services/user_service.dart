import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/entities/user.dart';

/// 🟢 UserService
/// مسؤول عن حفظ واسترجاع بيانات المستخدم محليًا (SharedPreferences)
/// تمامًا زي Fluxstore الأصلي.
class UserService {
  static const String _userKey = 'current_user';

  /// تحميل بيانات المستخدم من التخزين المحلي
  static Future<User?> loadUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);

    if (userJson == null || userJson.isEmpty) return null;

    try {
      final Map<String, dynamic> data = jsonDecode(userJson);
      return User.fromJson(data);
    } catch (e) {
      print('Error parsing user data: $e');
      return null;
    }
  }

  /// حفظ بيانات المستخدم في التخزين المحلي
  static Future<void> saveUserToStorage(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(user.toJson());
    await prefs.setString(_userKey, jsonString);
  }

  /// حذف بيانات المستخدم من التخزين (تسجيل الخروج)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  /// جلب المستخدم الحالي بدون تحميل من API (من الكاش فقط)
  static Future<User?> getCurrentUser() async {
    return await loadUserFromStorage();
  }

  /// فحص هل يوجد مستخدم مسجل دخول حالياً
  static Future<bool> isLoggedIn() async {
    final user = await loadUserFromStorage();
    return user != null && (user.token?.isNotEmpty ?? false);
  }
}
