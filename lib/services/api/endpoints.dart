class Endpoints {
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String forgotPassword = 'auth/forgot-password';
  static const String profile = 'user/profile';
}


class TestProviders {
  static const String dummyJsonBase = 'https://dummyjson.com';

  static String products({int limit = 8}) =>
      '$dummyJsonBase/products?limit=$limit';

  // ✅ Endpoint الفئات
  static String categories() => '$dummyJsonBase/products/categories';
}

