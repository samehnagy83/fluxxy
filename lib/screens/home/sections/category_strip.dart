import 'package:flutter/material.dart';
import '../../../common/widgets/section_title.dart';

// سيكشن الفئات: قائمة أفقية بأيقونة + اسم الفئة.
// لاحقًا: onTap تفتح CategoryScreen مع فلترة.
class CategoryStripSection extends StatelessWidget {
  final Map<String, dynamic> config;
  const CategoryStripSection({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final title = (config['title'] ?? '').toString();
    final items = (config['items'] as List?) ?? [];

    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) SectionTitle(title: title, onSeeAll: () {}),
        SizedBox(
          height: 98,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              final icon = (items[i]['icon'] ?? '').toString();
              final name = (items[i]['name'] ?? '').toString();
              return InkWell(
                onTap: () {
                  // TODO: الانتقال لشاشة الفئة المحددة
                },
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          icon,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(Icons.category_outlined),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 72,
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemCount: items.length,
          ),
        ),
      ],
    );
  }
}
