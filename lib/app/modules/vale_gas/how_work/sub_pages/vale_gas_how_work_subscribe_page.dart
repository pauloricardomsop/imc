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

class ValeGasHowWorkSubscribePage extends JourneyStatefulWidget {
  const ValeGasHowWorkSubscribePage({super.key}) : super(name: 'ValeGasHowWorkSubscribePage');

  @override
  State<ValeGasHowWorkSubscribePage> createState() => _BfHowWorkSubscribePage();
}

class _BfHowWorkSubscribePage extends State<ValeGasHowWorkSubscribePage> {
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
              const BackHeaderBenefit(benefit: Benefit.valeGas),
              const H(32),
              const HeaderHero(
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/CADASTRO-UNICO-jpg.webp',
                title: 'Como se inscrever para fazer parte do Vale Gás?',
                desc:
                    'Para receber o auxílio gás é necessário ter a família inscrita no Cadastro Único e ter renda mensal máxima de meio salário mínimo por pessoa.',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              const SectionHeaderSm('Entenda.',
                  'É possível fazer o pré-cadastro para recebimento do benefício pelo aplicativo do CadÚnico.\n\nO cadastro completo para registrar a família no CadÚnico é realizado em uma unidade do Centro de Referência de Assistência Social (CRAS).'),
              const H(8),
              const AppCardPurple(
                  'Vale destacar que a inscrição é um pré-requisito para receber o benefício, mas não garante entrada imediata no programa ou o recebimento do benefício.'),
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
