// الغرض من الملف: تعريف ترتيب وأنواع أقسام الهوم (Config) بنفس أسلوب Fluxstore.
// كل Section له type ومعه بياناته الخاصة، والـ HomeScreen هتبني الواجهة بناءً على هذا التعريف.
class HomeConfig {
  static final List<Map<String, dynamic>> sections = [
    {
      'type': 'bannerSlider',
      'items': [
        // روابط/أصول صور البنرات
        {'image': 'assets/images/onboard_1.png', 'link': '/'},
        {'image': 'assets/images/onboard_2.png', 'link': '/'},
        {'image': 'assets/images/onboard_1.png', 'link': '/'},
        {'image': 'assets/images/onboard_3.png', 'link': '/'},
      ],
      'autoPlay': true,
      'height': 180.0,
    },
    {
      'type': 'categoryStrip',
      'title': 'Shop by Category',
      // ✅ اجعل المصدر ديناميك من الـ API
      'source': {
        'provider': 'dummyjson',
        'limit': 12, // اختياري: أقصى عدد فئات
      },

      // ✅ (اختياري) ماب لصور فئات مخصصة لو حابب تربط صور لكل فئة
      // لو مش محدد، هنستخدم fallback avatar بحرف الفئة
      'categoryImages': {
        // 'smartphones': 'https://your-cdn.com/cat_smartphones.png',
        // 'laptops': 'https://your-cdn.com/cat_laptops.png',
      },
    },

    {
      'type': 'productGrid',
      'title': 'Featured Products',
      'layout': 'grid2', // grid2 | grid3 (اختيارية)
      'source': {
        'provider': 'dummyjson',
        'method': 'featured',
        'limit': 26,
      },
    },
  ];
}
