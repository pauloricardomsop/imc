import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_carroussel.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/button_icon.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/header_hero.dart';
import 'package:benefits_brazil/app/core/components/label_double_column.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:benefits_brazil/app/core/models/carroussel_model.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/bf/has_rights/ui/bf_has_rights_test_page.dart';
import 'package:flutter/material.dart';

class BfHasRightsHomePage extends JourneyStatefulWidget {
  const BfHasRightsHomePage({super.key}) : super(name: 'BfHasRightsHomePage');

  @override
  State<BfHasRightsHomePage> createState() => _BfHasRightsHomePage();
}

class _BfHasRightsHomePage extends State<BfHasRightsHomePage> {
  final List<CarrousselModel> _carrousselItens = [
    CarrousselModel(
      title: 'É possível se cadastrar no Bolsa Família pela Internet?',
      desc:
          'O Responsável Familiar pode fazer o pré-cadastro da família por meio do celular e tem até 120 dias para ir à unidade do CRAS fazer a entrega dos documentos e passar por uma entrevista social.\n\nO Responsável Familiar pode fazer o pré-cadastro da família por meio do celular e tem até 120 dias para ir à unidade do CRAS fazer a entrega dos documentos e passar por uma entrevista social.',
    ),
    CarrousselModel(
      title: 'O que é necessário para se inscrever no Bolsa Família?',
      desc:
          'É preciso que todos os membros da família estejam inscritos no CadÚnico e mantenham as informações atualizadas a cada dois anos. O titular deve comparecer ao CRAS levando seu CPF, o Título de eleitor e comprovante de residência e ainda levar uma cópia de cada documento para cada membro da família.',
    ),
    CarrousselModel(
      title: 'Como saber se eu tenho direito ao Bolsa Família 2023?',
      desc:
          'Além de estarem enquadradas na situação de pobreza e extrema pobreza, é preciso que as famílias tenham gestantes, mães que amamentam ou pessoas de 0 a 21 anos incompletos (crianças, adolescentes e jovens adultos).',
    ),
    CarrousselModel(
      title: 'O que é o Cadastro Único?',
      desc:
          'O Cadastro Único do Governo Federal, mais conhecido como CadÚnico, é o principal registro das famílias brasileiras de baixa renda e é muito importante para quem deseja receber benefícios e participar dos programas sociais disponibilizados.',
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
                image:
                    'https://ldcapps.com/wp-content/uploads/2023/03/veja-se-voce-tem-direito-1.png',
                title: 'Descubra se você tem direito ao Bolsa Família.',
                desc:
                    'Responda ao nosso Quiz super rápido para saber seu percentual de chances de se beneficiar do Bolsa Família.',
              ),
              const H(32),
              ButtonIcon(
                  onTap: () => push(context, const BfHasRightsTestPage()),
                  icon: Icons.arrow_forward,
                  label: 'Ir para o teste'),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(16),
              const H(32),
              const LabelDoubleColumn('Perguntas', 'Frequentes'),
            ],
          ),
        ),
        AppCarroussel(_carrousselItens),
        const H(16),
      ],
    );
  }
}
