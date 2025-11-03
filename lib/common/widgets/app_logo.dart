import 'package:flutter/material.dart';
import '../config/theme_config.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final String? title;

  const AppLogo({super.key, this.size = 80, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.shopping_bag_rounded,
            size: size, color: ThemeConfig.primaryColor),
        if (title != null) ...[
          const SizedBox(height: 12),
          Text(
            title!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: ThemeConfig.fontFamily,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ThemeConfig.textColor,
            ),
          ),
        ],
      ],
    );
  }
}
