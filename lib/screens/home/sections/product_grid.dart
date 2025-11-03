import 'package:flutter/material.dart';
import '../../../common/widgets/section_title.dart';

// شبكة المنتجات: تُظهر قائمة منتجات وفق تخطيط grid2/grid3.
// الآن بيانات وهمية (placeholder). لاحقًا نربطها بالـ API وفق source.
class ProductGridSection extends StatelessWidget {
  final Map<String, dynamic> config;
  const ProductGridSection({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final title = (config['title'] ?? '').toString();
    final layout = (config['layout'] ?? 'grid2').toString(); // grid2 | grid3
    final crossAxisCount = layout == 'grid3' ? 3 : 2;

    // Placeholder products (لاحقًا تُجلب من API)
    final items = List.generate(28, (i) {
      return {
        'name': 'Product ${i + 1}',
        'price': (19.9 + i).toStringAsFixed(2),
        'image': 'assets/images/product_${(i % 4) + 1}.jpg',
      };
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) SectionTitle(title: title, onSeeAll: () {}),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GridView.builder(
            shrinkWrap: true, // علشان تشتغل جوه ScrollView
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.66,
            ),
            itemBuilder: (_, i) {
              final p = items[i];
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
                          child: Image.asset(
                            (p['image'] ?? '').toString(),
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
                              (p['name'] ?? '').toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${(p['price'] ?? '').toString()}',
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
            },
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
