import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/header_hero.dart';
import 'package:benefits_brazil/app/core/components/stream_out.dart';
import 'package:benefits_brazil/app/core/components/w.dart';
import 'package:benefits_brazil/app/core/theme/app_theme.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/vale_gas/news/vale_gas_new_bottom_modal.dart';
import 'package:benefits_brazil/app/modules/vale_gas/news/vale_gas_news_controller.dart';
import 'package:benefits_brazil/app/modules/vale_gas/news/vale_gas_news_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ValeGasNewsPage extends JourneyStatefulWidget {
  const ValeGasNewsPage({super.key}) : super(name: 'ValGasNewsPage');

  @override
  State<ValeGasNewsPage> createState() => _BfNewsPage();
}

class _BfNewsPage extends State<ValeGasNewsPage> {
  final ValeGasNewsController _valeGasNewsController = ValeGasNewsController();

  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: AppScaffold(
          active: AdController.adConfig.banner.active,
          behavior: AdBannerStorage.get(widget.name),
          body: StreamOut<List<News>>(
            stream: _valeGasNewsController.newsStream.listen,
            child: (_, news) => body(_, news),
          ),
        ));
  }

  Widget body(_, List<News> news) {
    final topList = news.getRange(0, 6).toList();
    final bottomList = news.getRange(6, news.length).toList();
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              BackHeaderBenefit(),
              H(24),
              HeaderHero(
                title: 'Últimas Notícias',
                desc: 'Principais notícias do dia.',
              ),
              H(24),
            ],
          ),
        ),
        SizedBox(
          width: double.maxFinite,
          height: 160,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: topList.length,
            separatorBuilder: (_, i) => const W(8),
            itemBuilder: (_, i) => InkWell(
              onTap: () {
                AdController.showRewardAd(
                  onComplete: () => showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16), bottomLeft: Radius.circular(16))),
                    context: context,
                    builder: (_) => ValeGasNewBottomModal(topList[i]),
                  ),
                );
              },
              child: _itemNewsTop(_, topList[i]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const H(24),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(24),
              const HeaderHero(
                title: 'Vale Gás',
                desc: 'Confira as últimas notícias sobre o Vale Gás 2023.',
              ),
              const H(24),
              ...bottomList
                  .map((e) => InkWell(
                        onTap: () {
                          AdController.showRewardAd(
                            onComplete: () => showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      bottomLeft: Radius.circular(16))),
                              context: context,
                              builder: (_) => ValeGasNewBottomModal(e),
                            ),
                          );
                        },
                        child: _itemNewsBottom(_, e),
                      ))
                  .toList()
            ],
          ),
        )
      ],
    );
  }

  Container _itemNewsTop(_, News news) {
    return Container(
      width: 330,
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(color: const Color(0xFF000C61), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            news.title.length > 70 ? '${news.title.substring(0, 70)}...' : news.title,
            style: AppTheme.text.extra.lg(const Color(0xFFFEFCFC)),
          ),
          Text(
            '${DateFormat('dd/MM/yyyy').format(news.date!)} - ${DateFormat('HH:mm').format(news.date!)}h',
            style: AppTheme.text.normal.xs(const Color(0xFFDDE0FF)),
          )
        ],
      ),
    );
  }

  Container _itemNewsBottom(_, News news) {
    return Container(
      height: 105,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFC7C6C6))),
      child: Row(
        children: [
          Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              color: Colors.grey[800]!,
              image: const DecorationImage(
                  image: CachedNetworkImageProvider(
                      'https://ldcapps.com/wp-content/uploads/2023/03/logo-valegas.png'),
                  fit: BoxFit.cover),
              boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 2, spreadRadius: 1.5)],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const W(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  news.title.length > 50 ? '${news.title.substring(0, 50)}...' : news.title,
                  style: AppTheme.text.semi.base(const Color(0xFF1B1C1C)),
                ),
                const Spacer(),
                Text(
                  '${DateFormat('dd/MM/yyyy').format(news.date!)} - ${DateFormat('HH:mm').format(news.date!)}h',
                  style: AppTheme.text.normal.xs(const Color(0xFF1B1C1C)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
