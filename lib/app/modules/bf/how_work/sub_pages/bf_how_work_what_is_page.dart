import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/check_list.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/header_hero.dart';
import 'package:benefits_brazil/app/core/components/in_footer_cta.dart';
import 'package:benefits_brazil/app/core/components/section_header_sm.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:benefits_brazil/app/core/models/check_list_model.dart';
import 'package:benefits_brazil/app/core/theme/app_theme.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/bf/has_rights/ui/bf_has_rights_home_page.dart';
import 'package:flutter/material.dart';

class BfHowWorkWhatIsPage extends JourneyStatefulWidget {
  const BfHowWorkWhatIsPage({super.key}) : super(name: 'BfHowWorkWhatIsPage');

  @override
  State<BfHowWorkWhatIsPage> createState() => _BfHowWorkWhatIsPage();
}

class _BfHowWorkWhatIsPage extends State<BfHowWorkWhatIsPage> {
  final List<CheckListModel> _checkListItens = [
    CheckListModel(
      icon: Icons.done,
      label:
          'O Bolsa Família integra em apenas um programa várias políticas públicas de assistência social, saúde, educação, emprego e renda.',
    ),
    CheckListModel(
      icon: Icons.done,
      label:
          'O novo programa social de transferência direta e indireta de renda é destinado às famílias em situação de pobreza e de extrema pobreza em todo o país.',
    ),
    CheckListModel(
      icon: Icons.done,
      label:
          'Além de garantir uma renda básica a essas famílias, o programa busca simplificar a cesta de benefícios e estimular a emancipação dessas famílias para que alcancem autonomia e superem situações de vulnerabilidade social.',
    ),
    CheckListModel(
      icon: Icons.done,
      label:
          'O Bolsa Família é coordenado pelo Ministério da Cidadania, responsável por gerenciar os benefícios do programa e o envio de recursos para pagamento.',
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
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/o-que-e-o-bolsa-familia.png',
                title: 'O que é o Bolsa Família?',
                desc:
                    'O Bolsa Família é um programa assistencial que todo mês distribui renda para várias famílias brasileiras.',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              const SectionHeaderSm('Quais são os destaques do Bolsa Família?',
                  'Além de garantir renda básica para as famílias em situação de pobreza, o Programa Bolsa Família busca integrar políticas públicas, fortalecendo o acesso das famílias a direitos básicos como saúde, educação e assistência social.'),
              CheckList(_checkListItens),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text:
                      'Você pode descobrir quais as suas chances de participar do Bolsa Família, em nosso ',
                  style: AppTheme.text.normal.base(const Color(0xFF474747)),
                ),
                TextSpan(
                  text: 'Quiz do Bolsa Família',
                  style: AppTheme.text.semi.base(const Color(0xFF474747)),
                ),
              ]))
            ],
          ),
        ),
        const H(16),
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
