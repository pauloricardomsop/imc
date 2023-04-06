import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_card_purple.dart';
import 'package:benefits_brazil/app/core/components/app_item_carroussel.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/header_hero.dart';
import 'package:benefits_brazil/app/core/components/in_footer_cta.dart';
import 'package:benefits_brazil/app/core/components/section_header_sm.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:benefits_brazil/app/core/models/check_list_model.dart';
import 'package:benefits_brazil/app/core/models/carroussel_model.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/bf/has_rights/ui/bf_has_rights_home_page.dart';
import 'package:flutter/material.dart';

class BfHowWorkValuesAvailablePage extends JourneyStatefulWidget {
  const BfHowWorkValuesAvailablePage({super.key}) : super(name: 'BfHowWorkValuesAvailablePage');

  @override
  State<BfHowWorkValuesAvailablePage> createState() => _BfHowWorkValuesAvailablePage();
}

class _BfHowWorkValuesAvailablePage extends State<BfHowWorkValuesAvailablePage> {
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

  final List<CarrousselModel> _carrousselItens = [
    CarrousselModel(
      title: 'Benefício de Renda de Cidadania.',
      desc:
          'O benefício é pago para todos os integrantes da família, no valor de R\$ 142 por pessoa.',
    ),
    CarrousselModel(
      title: 'Benefício Complementar.',
      desc:
          'O benefício pago às famílias beneficiárias do Programa Bolsa Família, caso o Benefício de Renda de Cidadania não seja o suficiente para alcançar o valor mínimo de R\$600 por família. O complemento é calculado para garantir que nenhuma família receba menos que o valor de R\$ 600;',
    ),
    CarrousselModel(
      title: 'Benefício Primeira Infância.',
      desc:
          'Um benefício adicional no valor de R\$ 150 por criança com idade entre 0 (zero) e 6 anos;',
    ),
    CarrousselModel(
      title: 'Benefício Variável Familiar',
      desc:
          'Benefício pago às famílias que tenham em sua composição gestantes e/ou crianças, com idade entre 7 (sete) e 12 (doze) anos incompletos e/ou adolescentes, com idade entre 12 (doze) e 18 (dezoito) anos incompletos; no valor de R\$ 50 por pessoa que atenda estes critérios.',
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
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/como-receber-o-bolsa-familia.jpg',
                title: 'Quais valores estão disponíveis?',
                desc:
                    'Listamos abaixo, informações sobre os possíveis valores disponíveis por família.',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              const SectionHeaderSm('Valores disponíveis', 'Estes são os valores disponíveis.'),
              ListView.separated(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, i) => const H(8),
                itemBuilder: (_, i) => AppItemCarroussel(_carrousselItens[i]),
              ),
              const H(8),
              const AppCardPurple(
                  'O Benefício Primeira Infância será pago a partir de março de 2023. Por questões operacionais, os demais benefícios do Bolsa Família começarão a ser pagos a partir de junho de 2023. Até lá, será mantido o pagamento da cesta de benefícios do Programa Auxílio Brasil, com a adição do Benefício Primeira Infância do Bolsa Família.'),
              const H(8),
              AppItemCarroussel(_carrousselItens.last)
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
