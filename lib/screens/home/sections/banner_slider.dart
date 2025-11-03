import 'dart:async';
import 'package:flutter/material.dart';

// سيكشن سلايدر البنرات: يعرض صور بعرض الشاشة مع AutoPlay اختياري.
// لاحقًا ممكن نخلي الـ onTap يروح لروابط/شاشات حسب config.
class BannerSliderSection extends StatefulWidget {
  final Map<String, dynamic> config;
  const BannerSliderSection({super.key, required this.config});

  @override
  State<BannerSliderSection> createState() => _BannerSliderSectionState();
}

class _BannerSliderSectionState extends State<BannerSliderSection> {
  final _controller = PageController();
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final autoPlay = widget.config['autoPlay'] == true;
    if (autoPlay) {
      _timer = Timer.periodic(const Duration(seconds: 4), (t) {
        if (!mounted) return;
        final items = (widget.config['items'] as List?) ?? [];
        if (items.isEmpty) return;
        _index = (_index + 1) % items.length;
        _controller.animateToPage(
          _index,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = (widget.config['items'] as List?) ?? [];
    final height = (widget.config['height'] as num?)?.toDouble() ?? 180.0;

    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: height,
          child: PageView.builder(
            controller: _controller,
            itemCount: items.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) {
              final img = (items[i]['image'] ?? '').toString();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: const Text('Image not found'),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            items.length,
            (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _index == i ? 10 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _index == i ? Colors.teal : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
