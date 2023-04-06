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

class BfHowRegisterNecessaryDocumentsPage extends JourneyStatefulWidget {
  const BfHowRegisterNecessaryDocumentsPage({super.key})
      : super(name: 'BfHowRegisterNecessaryDocumentsPage');

  @override
  State<BfHowRegisterNecessaryDocumentsPage> createState() =>
      _BfHowRegisterNecessaryDocumentsPage();
}

class _BfHowRegisterNecessaryDocumentsPage extends State<BfHowRegisterNecessaryDocumentsPage> {
  final List<CheckListModel> _checkListItens = [
    CheckListModel(
      icon: Icons.done,
      label: 'Certidão de nascimento',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Comprovante de residência',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Certidão de casamento - caso seja casado(a)',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'CPF',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'RG',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Carteira de trabalho',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Título de eleitor',
    ),
    CheckListModel(
      icon: Icons.done,
      label:
          'Registro Administrativo de nascimento indígina (RANI) No caso se a pessoa for indígina.',
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
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/documentos-necessarios.jpg',
                title: 'Quais documentos são necessários?',
                desc:
                    'Listamos abaixo os documentos que você precisa apresentar na hora de se cadastrar no Bolsa Família.',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              const SectionHeaderSm('Confira quais documentos são necessários.',
                  'Você deve ter em mãos os seguintes documentos:'),
              CheckList(_checkListItens),
              Text(
                'Agora com esses documentos você já pode fazer seu cadastro no CadÚnico, para saber mais detalhes, volte e acesse os próximos passos.',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
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
