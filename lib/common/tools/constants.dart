/// يحتوي على الثوابت العامة المستخدمة في التطبيق كله
class AppConstants {
  /// مفاتيح التخزين (Shared Storage Keys)
  static const keyIsLoggedIn = 'is_logged_in';
  static const keyUserToken = 'user_token';
  static const keyUserEmail = 'user_email';
  static const keyUserJson = 'user_json';

  /// أسماء الصفحات (Routes)
  static const String routeSplash = '/';
  static const String routeInit = '/init';
  static const String routeHome = '/home';
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeForgotPassword = '/forgot-password';
  static const String routeOnboarding = '/onboarding';

  /// إعدادات عامة
  static const defaultLanguage = 'en';
  static const supportedLanguages = ['en', 'ar'];
  static const apiBaseUrl = 'https://example.com/api/';
}
