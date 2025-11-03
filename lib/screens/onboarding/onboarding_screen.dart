import 'package:flutter/material.dart';
import '../../common/config/theme_config.dart';
import '../../common/tools/constants.dart';
import '../../common/storage/local_storage.dart';

/// 🧭 OnboardingScreen
/// شاشة المقدمة (تعريفية قبل تسجيل الدخول)
/// نفس منطق Fluxstore الأصلي – تظهر مرة واحدة فقط عند أول تشغيل.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'image': 'assets/images/onboard_1.png',
      'title': 'Shop Easily',
      'subtitle': 'Discover thousands of products in one place.',
    },
    {
      'image': 'assets/images/onboard_2.png',
      'title': 'Secure Payments',
      'subtitle': 'Pay with confidence using multiple methods.',
    },
    {
      'image': 'assets/images/onboard_3.png',
      'title': 'Fast Delivery',
      'subtitle': 'Get your orders delivered quickly to your door.',
    },
  ];


  /// 🔹 عند الضغط على "ابدأ الآن"
  Future<void> _completeOnboarding() async {
    await LocalStorage.setBool('seen_onboarding', false);
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppConstants.routeHome);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ThemeConfig.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            slide['image']!,
                            width: size.width * 0.8,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          slide['title']!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: ThemeConfig.textColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          slide['subtitle']!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: ThemeConfig.hintColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 🔘 Indicators + Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                children: [
                  // 🔘 Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 12 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? ThemeConfig.primaryColor
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // 🎯 Next / Get Started Button
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _slides.length - 1) {
                        _completeOnboarding();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeConfig.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(
                      _currentPage == _slides.length - 1
                          ? 'Start Now'
                          : 'Next',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // ⏩ زر تخطي
                  if (_currentPage != _slides.length - 1) ...[
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: _completeOnboarding,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: ThemeConfig.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
