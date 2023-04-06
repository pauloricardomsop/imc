import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_card_purple.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/header_hero.dart';
import 'package:benefits_brazil/app/core/components/in_footer_cta.dart';
import 'package:benefits_brazil/app/core/components/section_header_sm.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class BfHowWorkSubscribePage extends JourneyStatefulWidget {
  const BfHowWorkSubscribePage({super.key}) : super(name: 'BfHowWorkSubscribePage');

  @override
  State<BfHowWorkSubscribePage> createState() => _BfHowWorkSubscribePage();
}

class _BfHowWorkSubscribePage extends State<BfHowWorkSubscribePage> {
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
        body: body(context),
      ),
    );
  }

  Widget body(_) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackHeaderBenefit(benefit: Benefit.bf),
              const H(32),
              const HeaderHero(
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/CADASTRO-UNICO-jpg.webp',
                title: 'Como se inscrever para fazer parte do Bolsa Família?',
                desc:
                    'O cadastramento é um pré-requisito, mas não significa que a família tem a entrada imediata no Programa. Mensalmente, o Programa Bolsa Família identifica, de forma automatizada, as famílias que serão incluídas e começarão a receber o benefício.',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              const SectionHeaderSm('Entenda.',
                  'A família elegível precisa estar devidamente inscrita no Cadastro Único para Programas Sociais do Governo Federal (Cadastro Único), com os dados corretos e atualizados, além de atender ao critério da renda limite. A inscrição é feita em um posto de cadastramento ou atendimento da assistência social no município.'),
              const H(8),
              const AppCardPurple(
                  'Para encontrar um posto de atendimento do Cadastro Único e do Bolsa Família mais próximo de você, saber quais as documentações necessárias para efetuar o cadastro ou para mais informações sobre cadastramento, acesse a página do MDS www.mds.gov.br e encontre a aba Serviços - Carta de Serviços'),
              const H(16),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: 'Você pode encontrar um CRAS em',
                  style: AppTheme.text.normal.base(const Color(0xFF474747)),
                ),
                TextSpan(
                  text: ' Encontre um CRAS',
                  style: AppTheme.text.semi.base(const Color(0xFF474747)),
                ),
              ])),
            ],
          ),
        ),
        const H(16),
        InFooterCta(
          onTap: () => execUrl('https://www.google.com/maps/search/CRAS/'),
          icon: Icons.near_me_outlined,
          label: 'Encontre um CRAS',
        )
      ],
    );
  }
}
