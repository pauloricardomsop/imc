import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart' as dk;
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class ConsulteValoresErrorPage extends AdStatefulWidget {
  ConsulteValoresErrorPage({
    Key? key,
  }) : super(key: key, name: 'ConsulteValoresErrorPage');

  @override
  State<ConsulteValoresErrorPage> createState() => ConsulteValoresErrorPageState();
}

class ConsulteValoresErrorPageState extends State<ConsulteValoresErrorPage> {
  List<CardFeature> get gridItens => [
        CardFeature(
          label: 'Serviços do Banco Central',
          prefix: Symbols.account_balance,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going, onDispose: () => push(context, Container())),
        ),
        CardFeature(
          label: 'Estatísticas\ndo SVR',
          prefix: Symbols.monitoring,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going, onDispose: () => push(context, Container())),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return dk.AppScaffold(
      hasBannerBottom: false,
      child: body(context),
    );
  }

  Widget body(_) {
    return dk.AppListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                titlePage(),
                const H(16),
                const AppDesc(
                    "Não foi possível acessar o Sistema de Valores a Receber neste momento. Tente novamente mais tarde."),
                const H(16),
                CardFeatures(gridItens),
                const H(16),
              ],
            ))
      ],
    );
  }

  Widget titlePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.cloud_off,
          size: 64,
          fill: 1,
          color: Color(0xFFFF7A00),
        ),
        const H(12),
        Text(
          'Serviço Temporariamente Indisponível',
          textAlign: TextAlign.center,
          // style: AppTheme.text.extra.xl2(
          //   const Color(0xFF1B1C1C),
          // ),
        ),
      ],
    );
  }
}
