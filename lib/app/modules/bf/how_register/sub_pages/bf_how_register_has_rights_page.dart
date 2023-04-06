import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_carroussel.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/check_list.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/header_hero.dart';
import 'package:benefits_brazil/app/core/components/in_footer_cta.dart';
import 'package:benefits_brazil/app/core/components/label_double_column.dart';
import 'package:benefits_brazil/app/core/components/section_header_sm.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:benefits_brazil/app/core/models/check_list_model.dart';
import 'package:benefits_brazil/app/core/models/carroussel_model.dart';
import 'package:benefits_brazil/app/core/theme/app_theme.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/bf/has_rights/ui/bf_has_rights_home_page.dart';
import 'package:flutter/material.dart';

class BfHowRegisterHasRightsPage extends JourneyStatefulWidget {
  const BfHowRegisterHasRightsPage({super.key}) : super(name: 'BfHowRegisterHasRightsPage');

  @override
  State<BfHowRegisterHasRightsPage> createState() => _BfHowRegisterHasRightsPage();
}

class _BfHowRegisterHasRightsPage extends State<BfHowRegisterHasRightsPage> {
  final List<CheckListModel> _checkListItens = [
    CheckListModel(
      icon: Icons.how_to_reg_outlined,
      label: 'Famílias em situação de extrema pobreza;',
    ),
    CheckListModel(
      icon: Icons.how_to_reg_outlined,
      label: 'Famílias em situação de pobreza;',
    ),
    CheckListModel(
      icon: Icons.how_to_reg_outlined,
      label: 'Famílias em regra de emancipação.',
    ),
  ];

  final List<CarrousselModel> _carrousselItens = [
    CarrousselModel(
      title: 'O que são famílias em situação de extrema pobreza?',
      desc:
          'São famílias com renda familiar mensal por pessoa de até R\$ 105,00 (cento e cinco reais).',
    ),
    CarrousselModel(
      title: 'O que são famílias em situação de pobreza?',
      desc:
          'São famílias com renda familiar mensal por pessoa entre R\$ 105,01 e R\$ 210,00 (cento e cinco reais e um centavo e duzentos e dez reais).',
    ),
    CarrousselModel(
      title: 'O que são famílias em regra de emancipação?',
      desc:
          'São famílias cujo beneficiário consegue um emprego formal e a renda ultrapassa a linha de pobreza (R\$ 210 por pessoa). Este poderá continuar recebendo o Bolsa Família por até dois anos, desde que a renda familiar mensal não ultrapasse R\$ 252 por pessoa.',
    ),
  ];

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
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackHeaderBenefit(benefit: Benefit.bf),
                  const H(32),
                  const HeaderHero(
                    image:
                        'https://ldcapps.com/wp-content/uploads/2023/03/pessoas-segurando-cartao-do-bolsa-familia.jpg',
                    title: 'Saiba se você tem direito ao Bolsa Família 2023',
                    desc:
                        'As regras para participar do programa Bolsa Família foram atualizadas. Confira abaixo quem tem direito ao benefício. ',
                  ),
                  const H(32),
                  AppBannerAd(AdBannerStorage.get(widget.name)),
                  const H(32),
                  const SectionHeaderSm('Quem pode participar?',
                      '​Podem participar do Programa as famílias\nnas seguintes situações:'),
                  CheckList(_checkListItens),
                  Text(
                    'Essas são as principais regras, porém existem outros detalhes, para verificar se você está dentro de todas as regras, responda nosso questionário clicando abaixo.',
                    style: AppTheme.text.normal.base(const Color(0xFF474747)),
                  ),
                  const H(32),
                  const LabelDoubleColumn('Perguntas', 'Frequentes'),
                ],
              ),
            ),
            AppCarroussel(_carrousselItens),
            const H(16),
          ],
        ),
        const H(100),
        InFooterCta(
          onTap: () {
            pops(context, 2);
            push(context, const BfHasRightsHomePage());
          },
          icon: Icons.quiz_outlined,
          label: 'Quiz do Bolsa Família',
        )
      ],
    );
  }
}
