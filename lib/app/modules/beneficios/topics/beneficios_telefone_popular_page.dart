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
              'Famílias inscritas no Cadastro Único com renda mensal por pessoa de até meio salário mínimo ou com renda familiar mensal total de até três salários mínimos.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'O responsável familiar deve entrar em contato com a concessionária de telefone fixo de sua região, tendo em mãos seu Número de Identificação Social (NIS) e seu CPF.'),
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
