import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/card_lg.dart';
import 'package:benefits_brazil/app/core/components/card_sm.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/label_double_column.dart';
import 'package:benefits_brazil/app/core/models/card_sm_model.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/bf/calendar/ui/bf_calendar_select_nis_page.dart';
import 'package:benefits_brazil/app/modules/bf/has_rights/ui/bf_has_rights_home_page.dart';
import 'package:benefits_brazil/app/modules/bf/how_register/bf_how_register_home_page.dart';
import 'package:benefits_brazil/app/modules/bf/how_work/bf_how_work_home_page.dart';
import 'package:benefits_brazil/app/modules/bf/news/bf_news_controller.dart';
import 'package:benefits_brazil/app/modules/bf/news/bf_news_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BfHomePage extends JourneyStatefulWidget {
  const BfHomePage({super.key}) : super(name: 'BfHomePage');

  @override
  State<BfHomePage> createState() => _BfHomePageState();
}

class _BfHomePageState extends State<BfHomePage> {
  final List<CardSmModel> _cardItens = [
    CardSmModel(
      title: 'Como funciona',
      subtitle: 'Entenda como funciona o Bolsa Família e quais são os valores do benefício.',
      page: const BfHowWorkHomePage(),
    ),
    CardSmModel(
      title: 'Tenho direito?',
      subtitle: 'Saiba se você tem direito ao benefício Bolsa Família.',
      page: const BfHasRightsHomePage(),
    ),
    CardSmModel(
      title: 'Como se cadastrar',
      subtitle: 'Aprenda como se cadastrar e como manter seu benefício Bolsa Família atualizado.',
      page: const BfHowRegisterHomePage(),
    ),
    CardSmModel(
      title: 'Calendário atualizado',
      subtitle: 'Fique atualizado sobre a data de pagamentos do seu benefício.',
      page: const BfCalendarSelectNisPage(),
    ),
    CardSmModel(
      title: 'Últimas notícias',
      subtitle: 'Encontre as últimas notícias sobre o programa Bolsa Família.',
      page: const BfNewsPage(),
    ),
  ];

  @override
  void initState() {
    BfNewsController().init();
    AdController.fetchRewardAd();
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
        body: body(context),
      ),
    );
  }

  Widget body(_) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const BackHeaderBenefit(),
        const H(16),
        CardLg(
          title: 'Bem vindo ao',
          subtitle: 'Bolsa Família',
          image: Container(
            margin: const EdgeInsets.all(8),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[800]!,
              image: const DecorationImage(
                  image: CachedNetworkImageProvider(
                      'https://ldcapps.com/wp-content/uploads/2023/03/o-que-e-o-bolsa-familia.png'),
                  fit: BoxFit.cover),
              boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 2, spreadRadius: 1.5)],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const H(32),
        AppBannerAd(AdBannerStorage.get(widget.name)),
        const H(32),
        const LabelDoubleColumn('Conteúdos', 'Bolsa Família 2023'),
        const H(8),
        ..._cardItens
            .map((e) => CardSm(
                  onTap: () => push(context, e.page),
                  title: e.title,
                  subtitle: e.subtitle,
                ))
            .toList()
      ],
    );
  }
}
