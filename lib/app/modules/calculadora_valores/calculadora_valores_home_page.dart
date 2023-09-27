import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/calculadora_valores/calculadora_valores_page.dart';
import 'package:svr/app/modules/consulta_pagamentos/ui/consulta_pagamentos_home_page.dart';
import 'package:svr/app/modules/saiba_voce_tem_direito/saiba_voce_tem_direito_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CalculadoraValoresHomePage extends AdStatefulWidget {
  CalculadoraValoresHomePage({Key? key})
      : super(key: key, name: 'CalculadoraValoresHomePage');

  @override
  State<CalculadoraValoresHomePage> createState() =>
      _CalculadoraValoresHomePageState();
}

class _CalculadoraValoresHomePageState
    extends State<CalculadoraValoresHomePage> {
  List<CardFeature> get gridItens => [
        CardFeature(
            label: 'Consultar Novo\nBolsa Família',
            prefix: Symbols.find_in_page,
            onTap: () => AdManager.showIntersticial(context,
                onDispose: () => push(context, ConsultaPagamentosHomePage()))),
        CardFeature(
            label: 'Saiba se você\ntem direito.',
            prefix: Symbols.tv_options_edit_channels,
            onTap: () => AdManager.showIntersticial(context,
                onDispose: () => push(context, SaibaVoceTemDireitoHomePage()))),
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
        Header(
          top: const HeaderTop(),
          title: 'Calculadora de valores do Novo Bolsa Família',
          desc:
              'Com esta calculadora você poderá informar a quantidade de pessoas que moram em sua residência, que se adequam aos benefícios adicionais do Novo Bolsa Família.',
          buttons: [
            AppButton(
              onTap: () => AdManager.showRewarded(
                  onDispose: () => push(context, CalculadoraValoresPage())),
              label: 'ACESSAR CALCULADORA',
              icon: const AdIcon(),
            ),
          ],
        ),
        const AppTitle('Veja mais opções.'),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardFeatures(gridItens)
      ],
    );
  }
}
