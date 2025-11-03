import 'package:flutter/material.dart';

/// إعدادات شاشة البداية (Splash / Loading)
class LoadingConfig {
  static const splashScreen = {
    'type': 'rive', // static | lottie | rive
    'image': 'assets/images/splashscreen.png',
    'lottie': 'assets/animations/splashscreen.json',
    'rive': 'assets/animations/splash2.riv',
    'fit': BoxFit.contain,
    'backgroundColor': Colors.white,
    'duration': 3000,
  };
}
