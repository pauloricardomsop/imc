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
import 'package:benefits_brazil/app/modules/vale_gas/has_rights/ui/vale_gas_has_rights_home_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/how_register/vale_gas_how_register_home_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/how_work/vale_gas_how_work_home_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/news/vale_gas_news_controller.dart';
import 'package:benefits_brazil/app/modules/vale_gas/news/vale_gas_news_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ValeGasHomePage extends JourneyStatefulWidget {
  const ValeGasHomePage({super.key}) : super(name: 'ValeGasHomePage');

  @override
  State<ValeGasHomePage> createState() => _ValeGasHomePageState();
}

class _ValeGasHomePageState extends State<ValeGasHomePage> {
  final List<CardSmModel> _cardItens = [
    CardSmModel(
      title: 'Como funciona',
      subtitle: 'Entenda como funciona o Vale Gás e quais são os valores do benefício.',
      page: const ValeGasHowWorkHomePage(),
    ),
    CardSmModel(
      title: 'Tenho direito?',
      subtitle: 'Saiba se você tem direito ao benefício Vale Gás.',
      page: const ValeGasHasRightsHomePage(),
    ),
    CardSmModel(
      title: 'Como se cadastrar',
      subtitle: 'Aprenda como se cadastrar e como manter seu benefício Vale Gás atualizado.',
      page: const ValeGasHowRegisterHomePage(),
    ),
    CardSmModel(
      title: 'Últimas notícias',
      subtitle: 'Encontre as últimas notícias sobre o programa Vale Gás.',
      page: const ValeGasNewsPage(),
    ),
  ];

  @override
  void initState() {
    ValeGasNewsController().init();
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
          subtitle: 'Vale Gás',
          image: Container(
            margin: const EdgeInsets.all(8),
            width: 60,
            height: 60,
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
        ),
        const H(32),
        AppBannerAd(AdBannerStorage.get(widget.name)),
        const H(32),
        const LabelDoubleColumn('Conteúdos', 'Vale Gás 2023'),
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
