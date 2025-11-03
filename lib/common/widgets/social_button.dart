import 'package:flutter/material.dart';
import '../config/theme_config.dart';

enum SocialType { google, apple, facebook, phone }

class SocialButton extends StatelessWidget {
  final SocialType type;
  final VoidCallback onPressed;

  const SocialButton({super.key, required this.type, required this.onPressed});

  String get _label => switch (type) {
        SocialType.google => 'Continue with Google',
        SocialType.apple => 'Continue with Apple',
        SocialType.facebook => 'Continue with Facebook',
        SocialType.phone => 'Continue with Phone',
      };

  IconData get _icon => switch (type) {
        SocialType.google => Icons.g_mobiledata, // يمكن تبديلها بأيقونة مخصصة لاحقًا
        SocialType.apple => Icons.apple,
        SocialType.facebook => Icons.facebook,
        SocialType.phone => Icons.phone_iphone,
      };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(_icon, color: ThemeConfig.textColor),
        label: Text(
          _label,
          style: const TextStyle(
            color: ThemeConfig.textColor,
            fontFamily: ThemeConfig.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFE0E0E0)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }
}
