import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/calculadora_renda/calculadora_renda_page.dart';
import 'package:svr/app/modules/consulta_pagamentos/ui/consulta_pagamentos_home_page.dart';
import 'package:svr/app/modules/saiba_voce_tem_direito/saiba_voce_tem_direito_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CalculadoraRendaHomePage extends AdStatefulWidget {
  CalculadoraRendaHomePage({Key? key})
      : super(key: key, name: 'CalculadoraRendaHomePage');

  @override
  State<CalculadoraRendaHomePage> createState() =>
      _CalculadoraRendaHomePageState();
}

class _CalculadoraRendaHomePageState extends State<CalculadoraRendaHomePage> {
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
          title: 'Calculadora de Renda',
          desc:
              'Com esta calculadora você poderá informar o total da renda familiar e o número total de pessoas que moram em sua residência, e assim a renda por pessoa será exibido.',
          buttons: [
            AppButton(
              onTap: () => AdManager.showRewarded(
                  onDispose: () => push(context, CalculadoraRendaPage())),
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
