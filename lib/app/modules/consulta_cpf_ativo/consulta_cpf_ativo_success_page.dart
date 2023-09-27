import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_cpf_ativo/topics/consulta_cpf_situacao_cadastrais_page.dart';
import 'package:svr/app/modules/consulta_pagamentos/ui/consulta_pagamentos_home_page.dart';
import 'package:svr/app/modules/saiba_voce_tem_direito/saiba_voce_tem_direito_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConsultaCpfAtivoSuccessPage extends AdStatefulWidget {
  final String nome;
  final String nis;
  ConsultaCpfAtivoSuccessPage(this.nome, this.nis, {Key? key})
      : super(key: key, name: 'ConsultaCpfAtivoSuccessPage');

  @override
  State<ConsultaCpfAtivoSuccessPage> createState() =>
      _ConsultaCpfAtivoSuccessPageState();
}

class _ConsultaCpfAtivoSuccessPageState
    extends State<ConsultaCpfAtivoSuccessPage> {
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
  List<CardFeature> get listFull => [
        CardFeature.full(
          label: 'Entenda a situação\ndo seu CPF',
          prefix: Symbols.assured_workload,
          sufix: Symbols.add_alert, //TODO: TROCAR POR ICONE DE ADICON
          onTap: () => AdManager.showRewarded(
              onDispose: () =>
                  push(context, ConsultaCpfAtivoSituacaoCadastraisPage())),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: body(context),
    );
  }

  Widget body(BuildContext context) {
    return AppListView(
      children: [
        Center(
          child: Text(
            'CPF encontrado.',
            textAlign: TextAlign.center,
            style: const TextStyle().bodyLarge,
          ),
        ),
        H(MediaQuery.of(context).size.width / 8),
        const Center(
          child: Icon(
            Icons.check_circle_rounded,
            color: AppColors.primary,
            size: 100,
          ),
        ),
        H(MediaQuery.of(context).size.width / 30),
        const H(16),
        Center(
          child: Text(
            'Situação Regular',
            style: const TextStyle(color: Color(0xFF334155)).titleLarge,
          ),
        ),
        Center(
          child: Text(
            'O resultado desta consulta não tem valor\nfiscal ou de crédito.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF020617)).bodyMedium,
          ),
        ),
        const H(12),
        AppButton.textButtons(
          label: 'VER DETALHES',
          onTap: () {},
          foregroundColor: AppColors.primary,
          backgroundColor: AppColors.surfaceContainerLowest,
          icon: Symbols.arrow_upward_alt,
        ),
        const H(8),
        const Divisor(),
        const H(24),
        CardFeatures.full(listFull),
        const H(24),
        const SelectYesNo(),
        const H(24),
        const AppTitle('Outras opções'),
        const H(24),
        CardFeatures(gridItens),
      ],
    );
  }
}
