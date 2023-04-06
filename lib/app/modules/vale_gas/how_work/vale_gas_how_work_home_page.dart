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
import 'package:benefits_brazil/app/modules/vale_gas/how_work/sub_pages/vale_gas_how_work_values_available_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/how_work/sub_pages/vale_gas_how_work_what_is_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/how_work/sub_pages/vale_gas_how_work_receive_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/how_work/sub_pages/vale_gas_how_work_subscribe_page.dart';
import 'package:flutter/material.dart';

import 'sub_pages/vale_gas_how_work_participate_page.dart';

class ValeGasHowWorkHomePage extends JourneyStatefulWidget {
  const ValeGasHowWorkHomePage({super.key}) : super(name: 'ValeGasHowWorkHomePage');

  @override
  State<ValeGasHowWorkHomePage> createState() => _ValeGasHowWorkHomePage();
}

class _ValeGasHowWorkHomePage extends State<ValeGasHowWorkHomePage> {
  final List<CardSmModel> _itensCard = [
    CardSmModel(
      title: 'O que é o Vale Gás?',
      subtitle: 'Entenda o que é o Vale Gás e quais são seus benefícios.',
      page: const ValeGasHowWorkWhatIsPage(),
    ),
    CardSmModel(
      title: 'Quais valores estão disponíveis?',
      subtitle: 'Veja os valores disponíveis e as regras para receber.',
      page: const ValeGasHowWorkValuesAvailablePage(),
    ),
    CardSmModel(
      title: 'Quem pode participar do Vale Gás?',
      subtitle: 'Veja quem pode participar do programa.',
      page: const ValeGasHowWorkParticipatePage(),
    ),
    CardSmModel(
      title: 'Como conseguir o Vale Gás',
      subtitle: 'Saiba o que fazer para conseguir participar do programa.',
      page: const ValeGasHowWorkSubscribePage(),
    ),
    CardSmModel(
      title: 'Como receber os benefícios?',
      subtitle: 'Saiba como receber os benefícios do Vale Gás.',
      page: const ValeGasHowWorkReceivePage(),
    ),
  ];

  final List<CarrousselModel> _carrousselItens = [
    CarrousselModel(
      title: 'É possível se cadastrar no Vale Gás pela Internet?',
      desc:
          'O Responsável Familiar pode fazer o pré-cadastro da família por meio do celular e tem até 120 dias para ir à unidade do CRAS fazer a entrega dos documentos e passar por uma entrevista social.\n\nO Responsável Familiar pode fazer o pré-cadastro da família por meio do celular e tem até 120 dias para ir à unidade do CRAS fazer a entrega dos documentos e passar por uma entrevista social.',
    ),
    CarrousselModel(
      title: 'O que é necessário para se inscrever no Vale Gás?',
      desc:
          'É preciso que todos os membros da família estejam inscritos no CadÚnico e mantenham as informações atualizadas a cada dois anos. O titular deve comparecer ao CRAS levando seu CPF, o Título de eleitor e comprovante de residência e ainda levar uma cópia de cada documento para cada membro da família.',
    ),
    CarrousselModel(
      title: 'Como saber se eu tenho direito ao Vale Gás 2023?',
      desc:
          'Além de estarem enquadradas na situação de pobreza e extrema pobreza, é preciso que as famílias tenham gestantes, mães que amamentam ou pessoas de 0 a 21 anos incompletos (crianças, adolescentes e jovens adultos).',
    ),
    CarrousselModel(
      title: 'O que é o Cadastro Único?',
      desc:
          'O Cadastro Único do Governo Federal, mais conhecido como CadÚnico, é o principal registro das famílias brasileiras de baixa renda e é muito importante para quem deseja receber benefícios e participar dos programas sociais disponibilizados. ',
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
              const HeaderHero(
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/como-saber-se-fui-aprovado.jpg',
                title: 'Como funciona o\nVale Gás 2023',
                desc: 'Saiba como funciona, e quais são os valores disponíveis no Vale Gás.',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              const LabelDoubleColumn('Fique por dentro de', 'Como Funciona'),
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
