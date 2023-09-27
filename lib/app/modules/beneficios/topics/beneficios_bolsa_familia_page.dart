import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class BeneficiosBolsaFamiliaPage extends AdStatefulWidget {
  BeneficiosBolsaFamiliaPage({Key? key})
      : super(key: key, name: 'BeneficiosBolsaFamiliaPage');

  @override
  State<BeneficiosBolsaFamiliaPage> createState() =>
      _BeneficiosBolsaFamiliaPageState();
}

class _BeneficiosBolsaFamiliaPageState
    extends State<BeneficiosBolsaFamiliaPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Famílias inscritas no Cadastro Único em situação de extrema pobreza (renda familiar por pessoa de até R\$ 100,00 mensais) OU famílias em situação de pobreza (com renda por pessoa entre R\$ 100,01 e R\$ 200,00 mensais) que possuem em sua composição gestantes ou pessoas com idade até 21 (vinte e um) anos incompletos.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'A seleção da família é feita de forma automática por um sistema informatizado, a partir dos dados informados no Cadastro Único e das regras do programa.'),
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
          title: 'Bolsa Família',
          desc:
              'Benefício pago a famílias em situação de extrema pobreza e pobreza inscritas no Cadastro Único.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
