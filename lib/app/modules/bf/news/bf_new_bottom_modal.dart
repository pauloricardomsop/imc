import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/button_icon.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/theme/app_theme.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/bf/news/bf_news_model.dart';
import 'package:flutter/material.dart';

class BfNewBottomModal extends JourneyStatefulWidget {
  final News news;
  const BfNewBottomModal(this.news, {super.key}) : super(name: 'BfNewBottomModal');

  @override
  State<BfNewBottomModal> createState() => _BfNewBottomModal();
}

class _BfNewBottomModal extends State<BfNewBottomModal> {
  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name + widget.news.title),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 700,
      decoration:
          BoxDecoration(color: const Color(0xFFFDFCFC), borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          const H(16),
          Center(
            child: Container(
              width: 40,
              height: 8,
              decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(50)),
            ),
          ),
          const H(16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                AppBannerAd(AdBannerStorage.get(widget.name + widget.news.title)),
                const H(16),
                Text(
                  widget.news.title,
                  // news.subtitle.length >= 800 ? news.subtitle.substring(0, 800) : news.subtitle,
                  // 'Descrição breve sobre a notícia com até 800 caracteres.',
                  style: AppTheme.text.normal.sm(const Color(0xFF6B7280)),
                ),
                const H(16),
                ButtonIcon(
                  onTap: () => execUrl(widget.news.url),
                  icon: Icons.open_in_new,
                  label: 'Ver Notícia Completa',
                  invert: true,
                ),
                const H(16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
