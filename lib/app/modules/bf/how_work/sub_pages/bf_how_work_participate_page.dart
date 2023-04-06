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
import 'package:benefits_brazil/app/modules/bf/has_rights/ui/bf_has_rights_home_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class BfHowWorkParticipatePage extends JourneyStatefulWidget {
  const BfHowWorkParticipatePage({super.key}) : super(name: 'BfHowWorkParticipatePage');

  @override
  State<BfHowWorkParticipatePage> createState() => _BfHowWorkParticipatePage();
}

class _BfHowWorkParticipatePage extends State<BfHowWorkParticipatePage> {
  final List<CheckListModel> _checkListItens = [
    CheckListModel(
      icon: Icons.done,
      label: 'Realização do acompanhamento pré-natal;',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Acompanhamento do calendário nacional de vacinação;',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Realização do acompanhamento do estado nutricional das crianças menores de 7 anos;',
    ),
    CheckListModel(
      icon: Icons.done,
      label:
          'Para as crianças de 4 (quatro) a 5 (cinco) anos, frequência escolar mínima de 60% (sessenta por cento) e 75% (setenta e cinco por cento) para os beneficiários de 6 (seis) anos a 18 (dezoito) anos incompletos que não tenham concluído a educação básica.',
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
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/quem-pode-participar.jpg',
                title: 'Quem pode participar do Bolsa Família?',
                desc:
                    'Para receber os benefícios, a principal regra é ter a renda mensal por pessoa de até R\$ 218 (duzentos e dezoito reais). Isso significa que toda a renda gerada pelas pessoas da família, por mês, dividida pelo número de pessoas da família, é de, no máximo, R\$218. Se a renda mensal por pessoa da família estiver neste critério, a família é elegível ao programa.',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              const SectionHeaderSm(
                  'Quais são as regras para continuar recebendo todo mês o benefício do Bolsa Família?',
                  'Para que a família mantenha a condição de beneficiária, os dados cadastrais deverão estar sempre atualizados, podendo ficar no máximo 24 meses sem atualização. Sempre que houver mudança de endereço, do telefone de contato e composição da sua família, como: nascimento de uma criança, falecimento de alguém da família, casamento e adoção, estas informações precisam ser informadas ao setor responsável pelo cadastramento no município. Isto garante que o Programa atenda às famílias de acordo com suas características. \n\nAlém disso, as famílias beneficiárias devem cumprir compromissos, nas áreas de saúde e de educação, para reforçar o acesso aos seus direitos sociais básicos, as chamadas condicionalidades. São elas:'),
              const H(8),
              CheckList(_checkListItens),
              const H(8),
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
              ])),
              const H(8),
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
