import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_nis/consulta_nis_controller.dart';
import 'package:svr/app/modules/consulta_nis/consulta_nis_model.dart';
import 'package:svr/app/modules/consulta_pagamentos/ui/consulta_pagamentos_home_page.dart';
import 'package:svr/app/modules/saiba_voce_tem_direito/saiba_voce_tem_direito_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConsultaCpfAtivoHomePage extends AdStatefulWidget {
  ConsultaCpfAtivoHomePage({Key? key})
      : super(key: key, name: 'ConsultaCpfAtivoHomePage');

  @override
  State<ConsultaCpfAtivoHomePage> createState() =>
      _ConsultaCpfAtivoHomePageState();
}

class _ConsultaCpfAtivoHomePageState extends State<ConsultaCpfAtivoHomePage> {
  final ConsultaNisController _controller = ConsultaNisController();

  @override
  void initState() {
    _controller.init();
    super.initState();
  }

  List<CardFeature> get gridItens => [
        CardFeature(
          label: 'Consultar Novo\nBolsa Família',
          prefix: Symbols.find_in_page,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, ConsultaPagamentosHomePage())),
        ),
        CardFeature(
          label: 'Saiba se você\ntem direito.',
          prefix: Symbols.tv_options_edit_channels,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, SaibaVoceTemDireitoHomePage())),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(
        AppButton.ad(
          onTap: () {},
          label: 'CONSULTAR',
        ),
      ),
      child: StreamOut<ConsultaNisModel>(
        stream: _controller.consultaNistream.listen,
        child: (_, model) => body(context, model),
      ),
    );
  }

  Widget body(_, ConsultaNisModel model) {
    return AppListView(
      children: [
        const Header(
          title: 'Verifique a situação de seu CPF.',
          desc:
              'Digite seu CPF no campo abaixo para realizar uma consulta nas bases de dados da Receita Federal.',
        ),
        AppField(
          controller: model.cpf,
          label: 'CPF',
          hint: '000.000.000-00',
          onChanged: (e) {},
          icon: Symbols.person_search,
          type: const TextInputType.numberWithOptions(
              decimal: false, signed: false),
        ),
        const H(16),
        AppField(
          controller: model.cpf,
          label: 'Data de nascimento',
          hint: '00/00/0000',
          onChanged: (e) {},
          icon: Symbols.calendar_month,
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
