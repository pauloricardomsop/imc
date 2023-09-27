import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class BeneficiosIsencaoConcursoPage extends AdStatefulWidget {
  BeneficiosIsencaoConcursoPage({Key? key})
      : super(key: key, name: 'BeneficiosIsencaoConcursoPage');

  @override
  State<BeneficiosIsencaoConcursoPage> createState() =>
      _BeneficiosIsencaoConcursoPageState();
}

class _BeneficiosIsencaoConcursoPageState
    extends State<BeneficiosIsencaoConcursoPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Pessoas inscritas no Cadastro Único com renda mensal por pessoa de até meio salário mínimo ou com renda familiar mensal total de até três salários mínimos.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'O candidato deverá solicitar a isenção da taxa de inscrição à entidade executora do concurso público, de acordo com as regras descritas no edital do certame concurso, e informar seu Número de Identificação Social (NIS).'),
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
          title: 'Isenção de taxas de inscrição em concursos públicos',
          desc:
              'Isenção da taxa de inscrição em concursos públicos realizados pelo Poder Executivo Federal.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
