import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/atendimento/atendimento_home_page.dart';
import 'package:svr/app/modules/calculadora_valores/calculadora_valores_home_page.dart';
import 'package:svr/app/modules/consulta_nis/ui/consulta_nis_home_page.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_controller.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_model.dart';
import 'package:svr/app/modules/saiba_voce_tem_direito/saiba_voce_tem_direito_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConsultaPagamentosHomePage extends AdStatefulWidget {
  ConsultaPagamentosHomePage({Key? key})
      : super(key: key, name: 'ConsultaPagamentosHomePage');

  @override
  State<ConsultaPagamentosHomePage> createState() =>
      _ConsultaPagamentosHomePageState();
}

class _ConsultaPagamentosHomePageState
    extends State<ConsultaPagamentosHomePage> {
  final ConsultaPagamentosController _controller =
      ConsultaPagamentosController();

  @override
  void initState() {
    super.initState();
  }

  List<CardFeature> get gridItens => [
        CardFeature(
          label: 'Encontre seu NIS\ncom CPF',
          prefix: Symbols.data_loss_prevention,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, ConsultaNisHomePage())),
        ),
        CardFeature(
          label: 'Saiba se você\ntem direito.',
          prefix: Symbols.tv_options_edit_channels,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, SaibaVoceTemDireitoHomePage())),
        ),
        CardFeature(
          label: 'Simular valores do Bolsa Família',
          prefix: Symbols.attach_money,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, CalculadoraValoresHomePage())),
        ),
        CardFeature(
          label: 'Canais de\nAtendimento',
          prefix: Symbols.support_agent,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, AtendimentoHomePage())),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(
        AppButton(
          onTap: () => _controller.onClickConsultar(context),
          label: 'CONSULTAR',
          icon: const AdIcon(),
        ),
      ),
      child: StreamOut<ConsultaPagamentosModel>(
        stream: _controller.consultaPagamentoStream.listen,
        child: (_, model) => body(context, model),
      ),
    );
  }

  Widget body(_, ConsultaPagamentosModel model) {
    return AppListView(
      children: [
        const Header(
          title: 'Consultar Pagamentos',
          desc:
              'Consulte extrato de pagamentos e próximos pagamentos do Novo Bolsa Família usando o número do seu NIS.',
        ),
        const H(16),
        AppField(
          controller: model.nis,
          label: 'NIS',
          hint: '0.000.000.000-0',
          onChanged: (e) => _controller.consultaPagamentoStream.update(),
          icon: Symbols.person_search,
          type: const TextInputType.numberWithOptions(
              decimal: false, signed: false),
        ),
        const H(8),
        const CardAlert.info('Não armazenamos seus dados ao fazer a consulta.'),
        const H(24),
        const AppTitle('Veja mais opções.'),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardFeatures(gridItens)
      ],
    );
  }
}
