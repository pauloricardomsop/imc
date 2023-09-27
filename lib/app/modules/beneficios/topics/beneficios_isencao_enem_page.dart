import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class BeneficiosIsencaoEnemPage extends AdStatefulWidget {
  BeneficiosIsencaoEnemPage({Key? key})
      : super(key: key, name: 'BeneficiosIsencaoEnemPage');

  @override
  State<BeneficiosIsencaoEnemPage> createState() =>
      _BeneficiosIsencaoEnemPageState();
}

class _BeneficiosIsencaoEnemPageState extends State<BeneficiosIsencaoEnemPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Famílias inscritas no Cadastro Único com renda familiar mensal por pessoa até meio salário mínimo ou três salários mínimos de renda familiar mensal total.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'O candidato deverá solicitar a isenção da taxa de inscrição no momento de inscrição no Enem, seguindo a orientação do edital.'),
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
          title: 'Isenções na taxa de inscrição para o Enem.',
          desc:
              'Concede isenções na taxa de inscrição para o Exame Nacional do Ensino Médio (Enem).',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
