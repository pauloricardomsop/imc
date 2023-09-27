import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class BeneficiosReformaAgrariaPage extends AdStatefulWidget {
  BeneficiosReformaAgrariaPage({Key? key})
      : super(key: key, name: 'BeneficiosReformaAgrariaPage');

  @override
  State<BeneficiosReformaAgrariaPage> createState() =>
      _BeneficiosReformaAgrariaPageState();
}

class _BeneficiosReformaAgrariaPageState
    extends State<BeneficiosReformaAgrariaPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Famílias de agricultores sem terra inscritos no Cadastro Único e com renda familiar total mensal de até 3 salários mínimos.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'As famílias interessadas que atendem aos requisitos do Programa devem fazer sua inscrição na Superintendência Regional do INCRA (SR) no seu estado, bastando apresentar documentos de identificação do interessado e do seu cônjuge ou parceiro, quando houver. \n\nPara saber onde encontrar a SR do INCRA no seu estado.'),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(AppButton(
        label: 'SITE REFORMA AGRÁRIA',
        onTap: () =>
            execUrl('https://www.gov.br/incra/pt-br/assuntos/reforma-agraria'),
        icon: Symbols.open_in_new,
      )),
      child: body(context),
    );
  }

  Widget body(_) {
    return AppListView(
      children: [
        const Header(
          top: HeaderTop(),
          title: 'Programa Nacional de Reforma Agrária',
          desc:
              'Linhas de créditos para famílias assentadas do Programa Nacional de Reforma Agrária (PNRA) que permitem a instalação no assentamento e o desenvolvimento de atividades produtivas nos lotes.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
