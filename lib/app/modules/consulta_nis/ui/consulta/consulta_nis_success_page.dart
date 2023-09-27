import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_pagamentos/ui/consulta_pagamentos_home_page.dart';
import 'package:svr/app/modules/saiba_voce_tem_direito/saiba_voce_tem_direito_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConsultaNisSuccessPage extends AdStatefulWidget {
  final String nome;
  final String nis;
  ConsultaNisSuccessPage(this.nome, this.nis, {Key? key})
      : super(key: key, name: 'ConsultaNisSuccessPage');

  @override
  State<ConsultaNisSuccessPage> createState() => _ConsultaNisSuccessPageState();
}

class _ConsultaNisSuccessPageState extends State<ConsultaNisSuccessPage> {
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

  Widget body(BuildContext context) {
    return AppListView(
      children: [
        Center(
          child: Text(
            'Beneficiário encontrado.',
            textAlign: TextAlign.center,
            style: const TextStyle().bodyLarge,
          ),
        ),
        H(MediaQuery.of(context).size.width / 8),
        const AppImage(
          url: 'assets/images/right.svg',
          isSVG: true,
          fit: BoxFit.contain,
        ),
        H(MediaQuery.of(context).size.width / 8),
        const H(16),
        Center(
          child: Text(
            widget.nome,
            style: const TextStyle(color: Color(0xFF334155)).bodyLarge,
          ),
        ),
        Center(
          child: Text(
            'NIS: ${widget.nis}',
            style: const TextStyle(color: Color(0xFF020617)).titleLarge,
          ),
        ),
        const H(12),
        CardCopy('Copiar NIS', () => copyClipboard(widget.nis)),
        const H(18),
        const Divisor(),
        const H(16),
        const SelectYesNo(),
        const H(24),
        const AppTitle('Outras opções'),
        const H(24),
        CardFeatures(gridItens),
      ],
    );
  }
}
