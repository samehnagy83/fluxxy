import 'package:flutter/material.dart';
import 'package:fluxxy/screens/onboarding/onboarding_screen.dart';
// App initializer that decides where to go after Splash
import 'app_init.dart';
// Screens
import 'screens/splash/splash_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/user/login_screen.dart';
import 'screens/user/register_screen.dart';
import 'screens/user/forgot_password_screen.dart';
// App-wide constants (routes, keys, etc.)
import 'common/tools/constants.dart';
import 'package:provider/provider.dart';
import 'models/user_model.dart';
import 'common/config/theme_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppClone());
}

class AppClone extends StatelessWidget {
  const AppClone({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Fluxy',
        theme: ThemeConfig.lightTheme,
        initialRoute: AppConstants.routeSplash,
        routes: {
          AppConstants.routeSplash: (_) => const SplashScreen(),
          AppConstants.routeInit: (_) => const AppInit(),
          AppConstants.routeHome: (_) => const HomeScreen(),
          AppConstants.routeLogin: (_) => const LoginScreen(),
          AppConstants.routeRegister: (_) => const RegisterScreen(),
          AppConstants.routeForgotPassword: (_) => const ForgotPasswordScreen(),
          AppConstants.routeOnboarding: (_) => const OnboardingScreen(),
        },
      ),
    );
  }
}
