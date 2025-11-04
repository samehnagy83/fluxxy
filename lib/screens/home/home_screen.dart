import 'package:flutter/material.dart';
import '../../common/config/home_config.dart';
import 'sections/section_factory.dart';

// شاشة الهوم: تبني الواجهة من أقسام ديناميكية وفق HomeConfig.
// كل سيكشن بيتبني عن طريق HomeSectionFactory عشان نفصل المنطق عن الواجهة.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // بناء قائمة Widgets بناءً على الـ sections
    final sectionWidgets = HomeConfig.sections
        .map((cfg) => HomeSectionFactory.build(context, cfg))
        .where((w) => w != null)
        .cast<Widget>()
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'), 
        actions: [
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: الانتقال لصفحة البحث
            },
          ),
          Stack(
            children: [
              IconButton(
                tooltip: 'Cart',
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () {
                  // TODO: الانتقال لصفحة السلة
                },
              ),
              // بادج عدد العناصر (placeholder)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('0', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
        ],
      ),
      // ممكن إضافة Drawer لاحقًا مع رابط Login (Guest Mode متاح)
      body: RefreshIndicator(
        // سحب للتحديث (لاحقًا يستدعي ريفريش للـ API لكل قسم)
        onRefresh: () async {
          // TODO: استدعاء إعادة تحميل البيانات لكل Section Model
          await Future.delayed(const Duration(milliseconds: 600));
        },
        child: CustomScrollView(
          slivers: [
            // استخدام Slivers لمرونة أعلى (مطابق لفكرة Fluxstore)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => sectionWidgets[index],
                childCount: sectionWidgets.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
