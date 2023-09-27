import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class BeneficiosInstalacaoReformaAgrariaPage extends AdStatefulWidget {
  BeneficiosInstalacaoReformaAgrariaPage({Key? key})
      : super(key: key, name: 'BeneficiosInstalacaoReformaAgrariaPage');

  @override
  State<BeneficiosInstalacaoReformaAgrariaPage> createState() =>
      _BeneficiosInstalacaoReformaAgrariaPageState();
}

class _BeneficiosInstalacaoReformaAgrariaPageState
    extends State<BeneficiosInstalacaoReformaAgrariaPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Famílias assentadas beneficiárias do Programa Nacional de Reforma Agrária (PNRA) inscritas no Cadastro Único com renda familiar mensal de até meio salário mínimo por pessoa ou até três salários mínimos de renda familiar total.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'Para solicitar acesso a alguma modalidade dos Créditos Instalação, as famílias assentadas devem procurar as Superintendências Regionais do Instituto Nacional de Colonização e Reforma Agrária (INCRA).'),
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
          title: 'Créditos Instalação do Programa Nacional de Reforma Agrária',
          desc:
              'São linhas de créditos para famílias assentadas do Programa Nacional de Reforma Agrária (PNRA) que permitem a instalação no assentamento e o desenvolvimento de atividades produtivas nos lotes.',
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const H(16),
              const BannerWidget(),
              const H(16),
              CardAppAccordeon(list),
            ],
          ),
        )
      ],
    );
  }
}
