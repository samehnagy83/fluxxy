import 'package:flutter/material.dart';
import 'package:fluxxy/common/config/theme_config.dart';
import 'package:fluxxy/models/user_model.dart';
import 'package:provider/provider.dart';
import 'common/tools/constants.dart';
import 'common/storage/local_storage.dart';

/// ⚙️ AppInit
/// شاشة التهيئة العامة للتطبيق.
/// مسؤولة عن:
/// - تهيئة LocalStorage
/// - تحميل بيانات المستخدم
/// - تحديد الشاشة المناسبة (Onboarding / Login / Home)
class AppInit extends StatefulWidget {
  const AppInit({super.key});

  @override
  State<AppInit> createState() => _AppInitState();
}

class _AppInitState extends State<AppInit> {
  bool _initializing = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  /// 🔹 تهيئة التطبيق (SharedPrefs, User, Configs, Onboarding check)
  Future<void> _initializeApp() async {
    try {
      // 1️⃣ تهيئة التخزين المحلي
      await LocalStorage.init();

      // 2️⃣ التحقق هل المستخدم شاف البوردنج قبل كده
      final seenOnboarding = LocalStorage.getBool(
        'seen_onboarding',
        defaultValue: false,
      );

      if (!seenOnboarding) {
        // أول مرة يفتح التطبيق → نوجه إلى شاشة البوردنج
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(AppConstants.routeOnboarding);
        return;
      }

      // 3️⃣ تحميل بيانات المستخدم من التخزين (لو موجود)
      final userModel = context.read<UserModel>();
      await userModel.loadFromStorage();

      // 4️⃣ انتظار بسيط لتزامن المدة مع شاشة الـ Splash
      // await Future.delayed(
      //   Duration(milliseconds: LoadingConfig.splashScreen['duration'] as int),
      // );

      // 5️⃣ بعد التحميل نقرر الوجهة
      if (!mounted) return;
      
      Navigator.of(context).pushReplacementNamed(AppConstants.routeHome);
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred during initialization: $e';
      });
    } finally {
      setState(() => _initializing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.backgroundColor,
      body: Center(
        child: _initializing
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    'Preparing the application...',
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeConfig.textColor,
                    ),
                  ),
                ],
              )
            : _errorMessage != null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.redAccent, size: 48),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _initializeApp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeConfig.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('try again'),
                      ),
                    ],
                  )
                : const Text(
                    'Data prepared successfully ✅',
                    style: TextStyle(fontSize: 16, color: ThemeConfig.textColor),
                  ),
      ),
    );
  }
  
}
