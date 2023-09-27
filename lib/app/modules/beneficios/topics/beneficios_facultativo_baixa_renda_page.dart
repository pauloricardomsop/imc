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
              'Pessoas que se dediquem exclusivamente ao trabalho doméstico no âmbito de sua residência, inscritas no Cadastro Único, sem renda pessoal e com renda familiar total mensal inferior a dois salários mínimos.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'A solicitação de inclusão na modalidade Contribuinte Facultativo de Baixa Renda é realizada em agência do INSS. É importante informar o Número de Identificação Social (NIS) no ato da inscrição. \n\nPara mais informações, ligue para a Central de Atendimento do INSS pelo telefone 135.'),
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
          title: 'Facultativo de Baixa Renda',
          desc:
              'Modalidade de contribuição ao INSS com valor reduzido (5% do salário mínimo) que permite acesso a coberturas previdenciárias como aposentadoria por idade ou invalidez e auxílios maternidade e doença.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
