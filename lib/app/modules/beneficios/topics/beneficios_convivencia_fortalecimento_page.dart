import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class BeneficiosConvivenciaFortalecimentoPage extends AdStatefulWidget {
  BeneficiosConvivenciaFortalecimentoPage({Key? key})
      : super(key: key, name: 'BeneficiosConvivenciaFortalecimentoPage');

  @override
  State<BeneficiosConvivenciaFortalecimentoPage> createState() =>
      _BeneficiosConvivenciaFortalecimentoPageState();
}

class _BeneficiosConvivenciaFortalecimentoPageState
    extends State<BeneficiosConvivenciaFortalecimentoPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Podem participar crianças, jovens e adultos; pessoas com deficiência; pessoas que sofreram violência, vítimas de trabalho infantil, jovens e crianças fora da escola, jovens que cumprem medidas socioeducativas, idosos sem amparo da família e da comunidade ou sem acesso a serviços sociais, além de outras pessoas inscritas no Cadastro Único.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'A família ou pessoa interessada em participar deve procurar o Centro de Referência da Assistência Social (CRAS) do seu município.'),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: body(context),
    );
  }

  Widget body(_) {
    return AppListView(
      children: [
        const Header(
          top: HeaderTop(),
          title: 'Serviço de Convivência e Fortalecimento de Vínculos',
          desc:
              'Atendimentos em grupo realizados nos CRAS e CREAS. \n\nSão atividades artísticas, culturais, de lazer e esportivas, dentre outras, de acordo com a idade dos usuários, com o objetivo de fortalecer as relações familiares e comunitárias, além de promover a integração e a troca de experiências entre os participantes, valorizando o sentido de vida coletiva.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
