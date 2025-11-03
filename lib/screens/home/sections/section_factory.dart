import 'package:flutter/material.dart';
import 'banner_slider.dart';
import 'category_strip.dart';
import 'product_grid.dart';

// مصنع الأقسام: يحوّل config إلى Widget مناسب.
// إضافة أنواع جديدة تتم بإضافة case جديد وربطه بملف الودجت الخاص به.
class HomeSectionFactory {
  static Widget? build(BuildContext context, Map<String, dynamic> cfg) {
    final type = (cfg['type'] ?? '').toString();

    switch (type) {
      case 'bannerSlider':
        return BannerSliderSection(config: cfg);
      case 'categoryStrip':
        return CategoryStripSection(config: cfg);
      case 'productGrid':
        return ProductGridSection(config: cfg);
      default:
        return null; // نوع غير معروف -> يتم تجاهله
    }
  }
}
