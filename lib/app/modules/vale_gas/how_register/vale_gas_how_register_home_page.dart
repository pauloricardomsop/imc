import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_carroussel.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/card_sm.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/header_hero.dart';
import 'package:benefits_brazil/app/core/components/label_double_column.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:benefits_brazil/app/core/models/card_sm_model.dart';
import 'package:benefits_brazil/app/core/models/carroussel_model.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/vale_gas/how_register/sub_pages/vale_gas_how_register_approved_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/how_register/sub_pages/vale_gas_how_register_cad_unico_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/how_register/sub_pages/vale_gas_how_register_has_rights_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/how_register/sub_pages/vale_gas_how_register_necessary_documents_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/how_register/sub_pages/vale_gas_how_register_receive_page.dart';
import 'package:flutter/material.dart';

class ValeGasHowRegisterHomePage extends JourneyStatefulWidget {
  const ValeGasHowRegisterHomePage({super.key}) : super(name: 'ValeGasHowRegisterHomePage');

  @override
  State<ValeGasHowRegisterHomePage> createState() => _ValeGasHowRegisterHomePage();
}

class _ValeGasHowRegisterHomePage extends State<ValeGasHowRegisterHomePage> {
  final List<CardSmModel> _itensCard = [
    CardSmModel(
      title: 'Veja se você tem direito',
      subtitle: 'Confira as condições para participar do Bolsa Família 2023',
      page: const ValeGasHowRegisterHasRightsPage(),
    ),
    CardSmModel(
      title: 'Documentos necessários',
      subtitle: 'Veja os documentos para receber o Bolsa Família em 2023',
      page: const ValeGasHowRegisterNecessaryDocumentsPage(),
    ),
    CardSmModel(
      title: 'CadÚnico',
      subtitle: 'Veja como se cadastrar ou atualizar o seu Cadastro Único',
      page: const ValeGasHowRegisterCadUnicoPage(),
    ),
    CardSmModel(
      title: 'Aprovação no benefício',
      subtitle: 'Como saber se você foi aprovado no Bolsa Família.',
      page: const ValeGasHowRegisterHasApprovedPage(),
    ),
    CardSmModel(
      title: 'Como receber o benefício?',
      subtitle: 'Agora que seu benefício foi aprovado, saiba como fazer para receber seu dinheiro.',
      page: const ValeGasHowRegisterHasReceivePage(),
    ),
  ];

  final List<CarrousselModel> _carrousselItens = [
    CarrousselModel(
      title: 'É possível se cadastrar no Vale Gás pela Internet?',
      desc:
          'O Responsável Familiar pode fazer o pré-cadastro da família por meio do celular e tem até 120 dias para ir à unidade do CRAS fazer a entrega dos documentos e passar por uma entrevista social.\n\nO Responsável Familiar pode fazer o pré-cadastro da família por meio do celular e tem até 120 dias para ir à unidade do CRAS fazer a entrega dos documentos e passar por uma entrevista social.',
    ),
  ];
  // final List<CarrousselModel> _carrousselItens = [
  //   CarrousselModel(
  //     title: 'O que são famílias em situação de extrema pobreza?',
  //     desc:
  //         'São famílias com renda familiar mensal por pessoa de até R\$ 105,00 (cento e cinco reais).',
  //   ),
  //   CarrousselModel(
  //     title: 'O que são famílias em situação de pobreza?',
  //     desc:
  //         'São famílias com renda familiar mensal por pessoa entre R\$ 105,01 e R\$ 210,00 (cento e cinco reais e um centavo e duzentos e dez reais).',
  //   ),
  //   CarrousselModel(
  //     title: 'O que são famílias em regra de emancipação?',
  //     desc:
  //         'São famílias cujo beneficiário consegue um emprego formal e a renda ultrapassa a linha de pobreza (R\$ 210 por pessoa). Este poderá continuar recebendo o Bolsa Família por até dois anos, desde que a renda familiar mensal não ultrapasse R\$ 252 por pessoa.',
  //   ),
  // ];

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
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/como-se-cadastrar-1.jpg',
                title: 'Como se cadastrar no Vale Gás 2023',
                desc: 'Veja abaixo o passo a passo necessário para se cadastrar no Vale Gás',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(16),
              ..._itensCard
                  .map((e) => CardSm(
                        onTap: () => push(context, e.page),
                        title: e.title,
                        subtitle: e.subtitle,
                      ))
                  .toList(),
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
