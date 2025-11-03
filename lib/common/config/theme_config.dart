import 'package:flutter/material.dart';

/// ThemeConfig مطابق لروح Fluxstore.
/// يحتوي على الألوان الأساسية والخطوط المستخدمة في الـ AppTheme.
class ThemeConfig {
  // ألوان أساسية (تماثل الألوان الموجودة في Fluxstore)
  static const Color primaryColor = Color(0xFF3FC1BE);
  static const Color secondaryColor = Color(0xFF006D77);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF333333);
  static const Color hintColor = Color(0xFF9E9E9E);

  // إعدادات الخط الافتراضي (Fluxstore يستخدم Roboto غالبًا)
  static const String fontFamily = 'Roboto';

  // ThemeData الأساسي
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: fontFamily,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      background: backgroundColor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textColor, fontSize: 16),
      bodyMedium: TextStyle(color: textColor, fontSize: 14),
      titleLarge:
          TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: textColor),
      titleTextStyle: TextStyle(
        color: textColor,
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: hintColor),
      ),
      hintStyle: const TextStyle(color: hintColor),
      labelStyle: const TextStyle(color: textColor),
    ),
  );

  // لاحقًا نضيف الـ Dark Theme لما نبدأ في وضع ليلي
}
