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
import 'package:flutter/material.dart';

class ValeGasHowRegisterCadUnicoPage extends JourneyStatefulWidget {
  const ValeGasHowRegisterCadUnicoPage({super.key}) : super(name: 'ValeGasHowRegisterCadUnicoPage');

  @override
  State<ValeGasHowRegisterCadUnicoPage> createState() => _ValeGasHowRegisterCadUnicoPage();
}

class _ValeGasHowRegisterCadUnicoPage extends State<ValeGasHowRegisterCadUnicoPage> {
  final List<CheckListModel> _checkListOneItens = [
    CheckListModel(
      icon: Icons.done,
      label: 'Comprovante de residência',
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
      label: 'Título de eleitor',
    ),
  ];
  final List<CheckListModel> _checkListTwoItens = [
    CheckListModel(
      icon: Icons.done,
      label: 'Não é obrigatório fazer seu pré-cadastro;',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Mesmo fazendo o pré-cadastro você ainda precisa comparecer a um CRAS;',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'O pré-cadastro funciona para agilizar seu atendimento presencial;',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'O pré-cadastro via aplicativo é válido por 60 dias até o comparecimento em um CRAS.',
    ),
  ];

  final List<CheckListModel> _checkListThreeItens = [
    CheckListModel(
      icon: Icons.done,
      label: 'Nascimento ou morte de alguém na família.',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Saída de um membro da família para outra casa.',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Mudança de endereço.',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Mudança de endereço.',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Entrada das crianças na escola ou transferência de escola;',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Entrada das crianças na escola ou transferência de escola;',
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
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/CADASTRO-UNICO-jpg.webp',
                title: 'Cadastro Único ou CadÚnico.',
                desc: 'Saiba como criar e atualizar o seu cadastro único',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              const SectionHeaderSm('Como se cadastrar pela primeira vez?',
                  'O Responsável Familiar deve comparecer ao CRAS levando os seguintes documentos'),
              CheckList(_checkListOneItens),
              Text(
                'É importante levar uma cópia de cada um desses documentos para cada membro da família.',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
              const H(24),
              Text(
                'Você pode buscar o CRAS mais próximo de você clicando no botão abaixo.',
                style: AppTheme.text.semi.base(const Color(0xFF474747)),
              ),
              const H(24),
              Text(
                'É possível também fazer um pré cadastro via Aplicativo CadÚnico, veja algumas informações importantes:',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
              const H(24),
              CheckList(_checkListTwoItens),
              const H(16),
              const SectionHeaderSm('No caso de atualização do seu CadÚnico',
                  'A atualização deve ser feita em uma unidade do CRAS mais próxima de você. A atualização deve ser feita a cada 2 anos. Porém, se houver qualquer mudança na situação dos membros que compõem o grupo familiar, antes dos dois anos, o cadastro também deverá ser atualizado.\n\nVeja em quais situações o cadastro deve ser atualizado antes do período de dois anos:'),
              const H(16),
              CheckList(_checkListThreeItens),
              Text(
                'Caso a família fique mais de quatro anos sem atualizar as informações cadastrais corre o risco de ser excluída do Cadastro Único.0',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
            ],
          ),
        ),
        const H(16),
        InFooterCta(
          onTap: () => execUrl('https://www.google.com/maps/search/CRAS/'),
          icon: Icons.near_me_outlined,
          label: 'Encontrar um CRAS',
        )
      ],
    );
  }
}
