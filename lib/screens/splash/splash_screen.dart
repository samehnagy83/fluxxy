import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart' as rive;
import '../../common/config/app_config.dart';
import '../../common/tools/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    final duration = Duration(milliseconds: LoadingConfig.splashScreen['duration'] as int);
    Timer(duration, () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(AppConstants.routeInit);
    });
  }

  @override
  Widget build(BuildContext context) {
    final splash = LoadingConfig.splashScreen;
    final bg = splash['backgroundColor'] as Color;
    final fit = splash['fit'] as BoxFit;
    final type = splash['type'] as String;

    Widget content;

    switch (type) {
      case 'lottie':
        content = Lottie.asset(
          splash['lottie'] as String,
          fit: fit,
        );
        break;
      case 'rive':
        content = rive.RiveAnimation.asset(
          splash['rive'] as String,
          fit: fit,
        );
        break;
      default:
        content = Image.asset(
          splash['image'] as String,
          fit: fit,
        );
    }

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Center(child: content),
      ),
    );
  }
}
