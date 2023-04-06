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
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/vale_gas/has_rights/ui/vale_gas_has_rights_home_page.dart';
import 'package:flutter/material.dart';

class ValeGasHowWorkParticipatePage extends JourneyStatefulWidget {
  const ValeGasHowWorkParticipatePage({super.key}) : super(name: 'ValeGasHowWorkParticipatePage');

  @override
  State<ValeGasHowWorkParticipatePage> createState() => _BfHowWorkParticipatePage();
}

class _BfHowWorkParticipatePage extends State<ValeGasHowWorkParticipatePage> {
  final List<CheckListModel> _checkListItens1 = [
    CheckListModel(
      icon: Icons.done,
      label:
          'Famílias inscritas no Cadastro Único (CadÚnico) que possuem renda mensal familiar até meio salário mínimo vigente por pessoa, inclusive beneficiárias de outros benefícios sociais;',
    ),
    CheckListModel(
      icon: Icons.done,
      label:
          'Famílias que possuam integrantes que recebem o Benefício de Prestação Continuada (BPC), inscritas ou não no CadÚnico;',
    ),
  ];

  final List<CheckListModel> _checkListIten2 = [
    CheckListModel(
      icon: Icons.done,
      label: 'Famílias com dados atualizados no CadÚnico nos últimos 2 anos;',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Famílias com menor renda por pessoa;',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Famílias beneficiárias do Auxílio Brasil;',
    ),
    CheckListModel(
      icon: Icons.done,
      label:
          'Famílias com cadastro qualificado pelo gestor por meio do uso dos dados da análise, quando disponíveis.',
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
              const BackHeaderBenefit(benefit: Benefit.valeGas),
              const H(32),
              HeaderHero(
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/quem-pode-participar.jpg',
                title: 'Quem pode participar do Vale Gás?',
                desc:
                    'Famílias com mulheres vítimas de violência doméstica que estejam sob monitoramento de medidas protetivas de urgência serão priorizadas.',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              const SectionHeaderSm(
                  'Quais são as regras para continuar recebendo todo mês o benefício do Vale Gás?',
                  'Confira quem tem direito ao benefício auxílio gás:'),
              const H(8),
              CheckList(_checkListItens1),
              //TODO VERIFY
              const SectionHeaderSm(
                  'Confira alguns critérios para recebimento do auxílio-gás:', empty),
              const H(8),
              CheckList(_checkListIten2),
              const H(8),
            ],
          ),
        ),
        const H(16),
        InFooterCta(
          onTap: () {
            pops(context, 2);
            push(context, const ValeGasHasRightsHomePage());
          },
          icon: Icons.quiz_outlined,
          label: 'Quiz do Bolsa Família',
        )
      ],
    );
  }
}
