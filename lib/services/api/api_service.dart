import 'package:dio/dio.dart';
import 'request.dart';
import 'endpoints.dart';

class ApiService {
  static Future<Response?> login(String email, String password) async {
    return await Request.post(Endpoints.login, data: {
      'email': email,
      'password': password,
    });
  }

  static Future<Response?> register(
      String name, String email, String password) async {
    return await Request.post(Endpoints.register, data: {
      'name': name,
      'email': email,
      'password': password,
    });
  }

  static Future<Response?> forgotPassword(String email) async {
    return await Request.post(Endpoints.forgotPassword, data: {
      'email': email,
    });
  }



  // دالة جلب منتجات من DummyJSON وفق limit
  static Future<List<Map<String, dynamic>>> fetchProductsFromDummyJson({
    int limit = 8,
  }) async {
    final res = await Request.getAbsolute(TestProviders.products(limit: limit));
    if (res != null && res.statusCode == 200) {
      final data = res.data;
      final List list = (data['products'] ?? []) as List;
      // نرجّع ليست من الخرائط بالمفاتيح اللي هنحتاجها في الواجهة
      return list.map<Map<String, dynamic>>((item) {
        return {
          'id': item['id'],
          'name': item['title'],
          'price': (item['price']?.toString() ?? '0'),
          'image': item['thumbnail'] ?? (item['images'] is List && item['images'].isNotEmpty ? item['images'][0] : null),
        };
      }).toList();
    }
    return [];
  }


  /// ✅ Fetch categories from DummyJSON
  static Future<List<Map<String, dynamic>>> fetchCategoriesFromDummyJson({
    int? limit,
  }) async {
    final Response? res = await Request.getAbsolute(TestProviders.categories());
    if (res != null && res.statusCode == 200) {
      final List data = (res.data as List?) ?? [];
      // DummyJSON يرجّع List<String> لأسماء الفئات
      final cats = data.map<String>((e) => e.toString()).toList();
      final sliced = (limit != null && limit > 0)
          ? cats.take(limit).toList()
          : cats;

      // رجّعناها map موحّد: id/slug/name (والصورة اختياريًا من الكونفيج)
      return sliced.map<Map<String, dynamic>>((name) {
        final slug = _slugify(name);
        return {
          'id': slug,
          'slug': slug,
          'name': _toTitle(name),
          // 'image': null, // سنحاول تزويدها من config داخل السيكشن
        };
      }).toList();
    }
    return [];
  }

  // Helpers
  static String _slugify(String input) =>
      input.toLowerCase().replaceAll(RegExp(r'\s+'), '-');

  static String _toTitle(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

}
