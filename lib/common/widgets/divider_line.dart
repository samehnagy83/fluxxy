import 'package:flutter/material.dart';
import '../config/theme_config.dart';

class DividerLine extends StatelessWidget {
  final String label;

  const DividerLine(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            color: ThemeConfig.hintColor,
            fontFamily: ThemeConfig.fontFamily,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
      ],
    );
  }
}
