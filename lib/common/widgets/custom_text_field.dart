import 'package:flutter/material.dart';
import '../config/theme_config.dart';

/// 🟢 CustomTextField
/// عنصر إدخال نصوص موحّد، مستخدم في صفحات تسجيل الدخول والتسجيل.
/// نفس الشكل المستخدم في Fluxstore (خلفية فاتحة + حواف دائرية).
class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final IconData? icon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.icon,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        style: const TextStyle(
          color: ThemeConfig.textColor,
          fontSize: 15,
          fontFamily: ThemeConfig.fontFamily,
        ),
        decoration: InputDecoration(
          prefixIcon:
              icon != null ? Icon(icon, color: ThemeConfig.hintColor) : null,
          labelText: label,
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ThemeConfig.hintColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ThemeConfig.primaryColor),
          ),
          labelStyle: const TextStyle(
            color: ThemeConfig.hintColor,
            fontSize: 14,
          ),
          hintStyle: const TextStyle(
            color: ThemeConfig.hintColor,
          ),
        ),
      ),
    );
  }
}
