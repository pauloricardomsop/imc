import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class BeneficiosSisuPage extends AdStatefulWidget {
  BeneficiosSisuPage({Key? key}) : super(key: key, name: 'BeneficiosSisuPage');

  @override
  State<BeneficiosSisuPage> createState() => _BeneficiosSisuPageState();
}

class _BeneficiosSisuPageState extends State<BeneficiosSisuPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Estudantes com renda familiar mensal por pessoa de até 1,5 salário mínimo e que cursaram integralmente o ensino médio em escola pública.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'Os candidatos que fizeram o Enem devem seguir suas instruções para solicitar e concorrer às vagas reservadas pela Lei de Cotas na inscrição para o SISU.'),
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
          title: 'Sistema de Seleção Unificada - Sisu/Lei de cotas',
          desc:
              'Reserva de vagas à estudantes com renda familiar mensal por pessoa de até 1,5 salário mínimo Instituições Federais de Ensino Superior.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
