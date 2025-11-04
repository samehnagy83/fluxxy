import 'package:flutter/material.dart';
import '../../../common/widgets/section_title.dart';
import '../../../services/api/api_service.dart';

/// ✅ CategoryStripSection (Dynamic)
/// - يجلب الفئات من API (DummyJSON) وفق source في config.
/// - يدعم صور مخصصة لكل فئة من config['categoryImages'].
/// - يعرض حالة Loading/Error.
class CategoryStripSection extends StatefulWidget {
  final Map<String, dynamic> config;
  const CategoryStripSection({super.key, required this.config});

  @override
  State<CategoryStripSection> createState() => _CategoryStripSectionState();
}

class _CategoryStripSectionState extends State<CategoryStripSection> {
  bool _loading = true;
  String? _error;
  List<Map<String, dynamic>> _categories = [];

  late final Map<String, String> _categoryImages; // name/slug -> imageUrl (optional)

  @override
  void initState() {
    super.initState();
    // حضّر ماب الصور (اختياري)
    final dynamic imagesCfg = widget.config['categoryImages'];
    _categoryImages = imagesCfg is Map
        ? imagesCfg.map<String, String>((k, v) => MapEntry(k.toString(), v.toString()))
        : <String, String>{};

    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final source = (widget.config['source'] ?? {}) as Map<String, dynamic>;
      final provider = (source['provider'] ?? 'dummyjson').toString();
      final int? limit = source['limit'] is int ? source['limit'] as int : null;

      List<Map<String, dynamic>> items = [];

      if (provider == 'dummyjson') {
        items = await ApiService.fetchCategoriesFromDummyJson(limit: limit);
      } else {
        // يمكنك لاحقًا إضافة مزودين آخرين بنفس الشكل
        items = [];
      }

      if (!mounted) return;
      setState(() {
        _categories = items;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load categories.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = (widget.config['title'] ?? '').toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) SectionTitle(title: title, onSeeAll: _onSeeAll),
        SizedBox(
          height: 108,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _buildBody(),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, __) => _loadingItem(),
      );
    }
    if (_error != null) {
      return Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!, style: const TextStyle(color: Colors.redAccent)),
            const SizedBox(width: 8),
            TextButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    }
    if (_categories.isEmpty) {
      return Center(
        child: Text(
          'No categories found.',
          style: TextStyle(color: Colors.grey.shade600),
        ),
      );
    }

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, i) => _categoryItem(_categories[i]),
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemCount: _categories.length,
    );
  }

  // عنصر فئة واحد (صورة أو Avatar + اسم)
  Widget _categoryItem(Map<String, dynamic> cat) {
    final String name = (cat['name'] ?? '').toString();
    final String slug = (cat['slug'] ?? '').toString();

    // جرّب تجيب صورة من config أولًا (by slug or name)
    final String? imageUrl =
        _categoryImages[slug] ?? _categoryImages[name.toLowerCase()];

    return InkWell(
      onTap: () {
        // TODO: الانتقال لشاشة Category مع تمرير slug/name
        // Navigator.of(context).pushNamed(AppConstants.routeCategory, arguments: {'slug': slug, 'name': name});
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
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _fallbackAvatar(name),
                    )
                  : _fallbackAvatar(name),
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
  }

  // صورة بديلة بحرف أول من اسم الفئة (لو مفيش صورة)
  Widget _fallbackAvatar(String name) {
    final String letter = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Container(
      color: const Color(0xFFF3F3F3),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  // عنصر لودينج بسيط
  Widget _loadingItem() {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFEDEDED),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Container(
          width: 56,
          height: 12,
          decoration: BoxDecoration(
            color: const Color(0xFFEDEDED),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ],
    );
  }

  void _onSeeAll() {
    // TODO: افتح شاشة كل الفئات
    // Navigator.of(context).pushNamed(AppConstants.routeAllCategories);
  }
}
