import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class BeneficiosTarifaSocialPage extends AdStatefulWidget {
  BeneficiosTarifaSocialPage({Key? key})
      : super(key: key, name: 'BeneficiosTarifaSocialPage');

  @override
  State<BeneficiosTarifaSocialPage> createState() =>
      _BeneficiosTarifaSocialPageState();
}

class _BeneficiosTarifaSocialPageState
    extends State<BeneficiosTarifaSocialPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Famílias inscritas no Cadastro Único com: renda familiar mensal por pessoa de até meio salário mínimo; OU com renda familiar total de até três salários mínimos, caso tenham entre seus membros portador de doença ou patologia cujo tratamento médico requeira o uso continuado de aparelhos que demandem consumo de energia elétrica para o seu funcionamento; OU famílias beneficiárias do BPC. \n\nAs famílias identificadas como indígenas ou quilombolas no Cadastro Único e que possuem renda mensal por pessoa de até meio salário terão direito ao desconto de 100% na conta de energia elétrica, até o limite de consumo de 50 KWh/mês.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'O responsável pela família deve solicitar a Tarifa Social de Energia Elétrica à distribuidora local de energia elétrica, informando seus dados pessoais, inclusive o Número de Identificação Social (NIS).'),
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
          title: 'Tarifa Social de Energia',
          desc:
              'Desconto na conta de luz para famílias de baixa renda ou que tenham algum componente beneficiário do Benefício de Prestação Continuada (BPC). Famílias indígenas ou quilombolas que se encaixem nos critérios podem ter desconto de 100%.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
