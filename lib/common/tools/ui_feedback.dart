import 'package:flutter/material.dart';

/// 🧠 UIFeedback
/// أداة موحدة لعرض الرسائل (نجاح / خطأ / تنبيه)
/// Fluxstore بيستخدم Widgets مشابهة لده عند الأخطاء أو العمليات الناجحة.
class UIFeedback {
  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.green);
  }

  static void showError(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.redAccent);
  }

  static void showInfo(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.blueAccent);
  }

  static void _showSnackBar(BuildContext context, String message, Color color) {
    if (message.isEmpty) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
