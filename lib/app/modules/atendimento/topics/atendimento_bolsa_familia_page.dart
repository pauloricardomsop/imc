import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/utils/global_resource.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class AtendimentoBolsaFamiliaPage extends AdStatefulWidget {
  AtendimentoBolsaFamiliaPage({Key? key})
      : super(key: key, name: 'AtendimentoBolsaFamiliaPage');

  @override
  State<AtendimentoBolsaFamiliaPage> createState() =>
      _AtendimentoBolsaFamiliaPageState();
}

class _AtendimentoBolsaFamiliaPageState
    extends State<AtendimentoBolsaFamiliaPage> {
  List<CardFeature> get listCards => [
        CardFeature.full(
          label: 'Atendimento por \ntelefone - 111',
          prefix: Symbols.call,
          sufix: Symbols.open_in_new,
          onTap: () => execUrl('tel:111'),
        )
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
        _headerInfoPagamento(_),
        CardFeatures.full(listCards),
        const H(16),
        const BannerWidget(),
        const H(16),
        const AppDesc(
            'O atendimento eletrônico está disponível 24 horas por dia, 7 dias por semana.')
      ],
    );
  }

  Header _headerInfoPagamento(_) {
    return const Header(
      backgroundColor: AppColors.primaryShadow,
      top: HeaderTop(backgroundColor: AppColors.primaryShadow),
      title: 'Atendimento do \nBolsa Família',
      desc:
          'Encontre atendimento para tirar dúvidas sobre o programa Bolsa Família',
    );
  }
}
