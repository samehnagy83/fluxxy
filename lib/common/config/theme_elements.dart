import 'package:flutter/material.dart';
import 'theme_config.dart';

/// 🔹 ThemeElements
/// يحتوي على عناصر تصميم جاهزة (AppBar, Buttons, TextStyles)
/// عشان نستخدمها في كل الشاشات بدون تكرار.
class ThemeElements {
  /// AppBar موحد
  static PreferredSizeWidget appBar(String title,
      {List<Widget>? actions, Color? backgroundColor}) {
    return AppBar(
      backgroundColor: backgroundColor ?? ThemeConfig.backgroundColor,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: ThemeConfig.fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: ThemeConfig.textColor,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      actions: actions,
      iconTheme: const IconThemeData(color: ThemeConfig.textColor),
    );
  }

  /// زر رئيسي (Primary Button)
  static Widget primaryButton({
    required String text,
    required VoidCallback onPressed,
    double height = 50,
    double borderRadius = 12,
  }) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeConfig.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: ThemeConfig.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// TextStyle موحد للعناوين
  static const TextStyle titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: ThemeConfig.textColor,
  );

  /// TextStyle موحد للنصوص العادية
  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    color: ThemeConfig.textColor,
  );

  /// BoxDecoration عام للكروت والخلفيات
  static BoxDecoration cardBox({Color? color}) => BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      );
}
