import 'package:shared_preferences/shared_preferences.dart';

/// 🧩 LocalStorage
/// كلاس موحد للتعامل مع SharedPreferences في المشروع.
/// Fluxstore بيستخدم نفس الفكرة لتخزين أي إعدادات أو بيانات بسيطة.
class LocalStorage {
  static SharedPreferences? _prefs;

  /// تهيئة SharedPreferences مرة واحدة في بداية التشغيل
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// حفظ قيمة String
  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  /// حفظ قيمة Bool
  static Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  /// حفظ قيمة Int
  static Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  /// قراءة String
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// قراءة Bool
  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  /// قراءة Int
  static int getInt(String key, {int defaultValue = 0}) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  /// حذف مفتاح محدد
  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  /// مسح جميع البيانات
  static Future<void> clear() async {
    await _prefs?.clear();
  }

  /// فحص هل تم التهيئة
  static bool get isInitialized => _prefs != null;
}
