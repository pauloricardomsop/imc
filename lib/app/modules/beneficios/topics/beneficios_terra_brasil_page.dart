import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class BeneficiosTelefonePopularPage extends AdStatefulWidget {
  BeneficiosTelefonePopularPage({Key? key})
      : super(key: key, name: 'BeneficiosTelefonePopularPage');

  @override
  State<BeneficiosTelefonePopularPage> createState() =>
      _BeneficiosTelefonePopularPageState();
}

class _BeneficiosTelefonePopularPageState
    extends State<BeneficiosTelefonePopularPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Famílias de trabalhadores rurais inscritas no Cadastro Único, que estão na área de abrangência da Sudene e nos estados da região Norte, com renda familiar anual de até R\$ 22.622,65 e patrimônio de até R\$ 40 mil.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'O interessado deve procurar os Sindicatos de Produtores Rurais, dos Trabalhadores ou da Agricultura Familiar, Prefeituras e empresas de ATER, ou entrar em contato com a Unidade Técnica Estadual (UTE).'),
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
          title: 'Terra Brasil - Programa Nacional de Crédito Fundiário',
          desc:
              'Oferece condições de financiamento para desenvolvimento de famílias rurais comprarem imóvel rural, investir em infraestrutura para a produção e/ou contratar assistência técnica.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
