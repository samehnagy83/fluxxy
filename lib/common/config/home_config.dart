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
      'items': [
        {'icon': 'assets/images/instagram.png', 'name': 'Electronics'},
        {'icon': 'assets/images/instagram.png', 'name': 'Fashion'},
        {'icon': 'assets/images/instagram.png', 'name': 'Beauty'},
        {'icon': 'assets/images/instagram.png', 'name': 'Home'},
        {'icon': 'assets/images/instagram.png', 'name': 'Toys'},
      ],
    },
    {
      'type': 'productGrid',
      'title': 'Featured Products',
      'layout': 'grid2', // grid2 | grid3 (اختيارية)
      'source': {
        // لاحقًا تتبدّل بنداءات API (فلترة/تصنيف/كلمة مفتاحية)
        'method': 'featured',
        'limit': 8,
      },
    },
  ];
}
