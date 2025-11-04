import 'package:flutter/material.dart';
import '../../../common/widgets/section_title.dart';
import '../../../services/api/api_service.dart';
import '../../../common/tools/ui_feedback.dart';

/// شبكة المنتجات: تُظهر قائمة منتجات وفق تخطيط grid2/grid3.
/// الآن مربوطة بمزوّد DummyJSON للاختبار بناءً على source.limit في الـ config.
class ProductGridSection extends StatefulWidget {
  final Map<String, dynamic> config;
  const ProductGridSection({super.key, required this.config});

  @override
  State<ProductGridSection> createState() => _ProductGridSectionState();
}

class _ProductGridSectionState extends State<ProductGridSection> {
  bool _loading = true;      // حالة التحميل
  String? _error;            // رسالة خطأ لو حصل
  List<Map<String, dynamic>> _items = []; // المنتجات

  @override
  void initState() {
    super.initState();
    _load();
  }

  // جلب البيانات وفق المصدر المحدد في config
  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final source = (widget.config['source'] ?? {}) as Map<String, dynamic>;
      final provider = (source['provider'] ?? 'dummyjson').toString();
      final limit = (source['limit'] is int) ? source['limit'] as int : 8;

      List<Map<String, dynamic>> products = [];

      // التبديل حسب المزوّد (دلوقتي dummyjson فقط؛ ممكن تضيف مزوّدين آخرين لاحقًا)
      if (provider == 'dummyjson') {
        products = await ApiService.fetchProductsFromDummyJson(limit: limit);
      } else {
        // مزوّد غير مدعوم حاليًا
        products = [];
      }

      if (!mounted) return;
      setState(() {
        _items = products;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load products.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = (widget.config['title'] ?? '').toString();
    final layout = (widget.config['layout'] ?? 'grid2').toString(); // grid2 | grid3
    final crossAxisCount = layout == 'grid3' ? 3 : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) SectionTitle(title: title, onSeeAll: _onSeeAll),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: _buildBody(crossAxisCount),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  // جسم السيكشن: تحميل / خطأ / شبكة المنتجات
  Widget _buildBody(int crossAxisCount) {
    if (_loading) {
      return _buildLoadingGrid(crossAxisCount);
    }
    if (_error != null) {
      // عرض رسالة خطأ بسيطة + زر إعادة المحاولة
      return Column(
        children: [
          Container(
            height: 120,
            alignment: Alignment.center,
            child: Text(
              _error!,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
          TextButton(onPressed: _load, child: const Text('Retry')),
        ],
      );
    }
    if (_items.isEmpty) {
      return SizedBox(
        height: 120,
        child: Center(
          child: Text(
            'No products found.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.66,
      ),
      itemBuilder: (_, i) => _buildProductCard(_items[i]),
    );
  }

  // كارت المنتج (بسيط وشيك)
  Widget _buildProductCard(Map<String, dynamic> p) {
    final name = (p['name'] ?? '').toString();
    final price = (p['price'] ?? '').toString();
    final image = (p['image'] ?? '').toString();

    return InkWell(
      onTap: () {
        // TODO: الانتقال لتفاصيل المنتج
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade100,
                    alignment: Alignment.center,
                    child: const Icon(Icons.image_not_supported_outlined),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // شبكة لودينج (سكيليتون بسيط بدون مكتبات)
  Widget _buildLoadingGrid(int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.66,
      ),
      itemBuilder: (_, __) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerBar(width: 120, height: 12),
                  const SizedBox(height: 8),
                  _shimmerBar(width: 60, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // بار رمادي بسيط لتمثيل السكيليتون
  Widget _shimmerBar({double width = 100, double height = 10}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  // زر "See all" — لاحقًا يفتح شاشة فيها كل المنتجات
  void _onSeeAll() {
    UIFeedback.showInfo(context, 'See all tapped'); // Placeholder
  }
}




// import 'package:flutter/material.dart';
// import '../../../common/widgets/section_title.dart';

// // شبكة المنتجات: تُظهر قائمة منتجات وفق تخطيط grid2/grid3.
// // الآن بيانات وهمية (placeholder). لاحقًا نربطها بالـ API وفق source.
// class ProductGridSection extends StatelessWidget {
//   final Map<String, dynamic> config;
//   const ProductGridSection({super.key, required this.config});

//   @override
//   Widget build(BuildContext context) {
//     final title = (config['title'] ?? '').toString();
//     final layout = (config['layout'] ?? 'grid2').toString(); // grid2 | grid3
//     final crossAxisCount = layout == 'grid3' ? 3 : 2;

//     // Placeholder products (لاحقًا تُجلب من API)
//     final items = List.generate(28, (i) {
//       return {
//         'name': 'Product ${i + 1}',
//         'price': (19.9 + i).toStringAsFixed(2),
//         'image': 'assets/images/product_${(i % 4) + 1}.jpg',
//       };
//     });

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (title.isNotEmpty) SectionTitle(title: title, onSeeAll: () {}),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: GridView.builder(
//             shrinkWrap: true, // علشان تشتغل جوه ScrollView
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: items.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: crossAxisCount,
//               mainAxisSpacing: 12,
//               crossAxisSpacing: 12,
//               childAspectRatio: 0.66,
//             ),
//             itemBuilder: (_, i) {
//               final p = items[i];
//               return InkWell(
//                 onTap: () {
//                   // TODO: الانتقال لتفاصيل المنتج
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.grey.shade200),
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.04),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: ClipRRect(
//                           borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                           child: Image.asset(
//                             (p['image'] ?? '').toString(),
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                             errorBuilder: (_, __, ___) => Container(
//                               color: Colors.grey.shade100,
//                               alignment: Alignment.center,
//                               child: const Icon(Icons.image_not_supported_outlined),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 8, 10, 6),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               (p['name'] ?? '').toString(),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle(fontWeight: FontWeight.w600),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               '\$${(p['price'] ?? '').toString()}',
//                               style: const TextStyle(
//                                 color: Colors.teal,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 12),
//       ],
//     );
//   }
// }
