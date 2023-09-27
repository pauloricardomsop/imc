import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_nis/consulta_nis_controller.dart';
import 'package:svr/app/modules/consulta_nis/consulta_nis_model.dart';
import 'package:svr/app/modules/consulta_nis/ui/topics/consulta_nis_cartao_cidadao_page.dart';
import 'package:svr/app/modules/consulta_nis/ui/topics/consulta_nis_site_cnis_page.dart';
import 'package:svr/app/modules/consulta_nis/ui/topics/consulta_nis_site_meu_inss.dart';
import 'package:svr/app/modules/consulta_nis/ui/topics/consulta_nis_telefone_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConsultaNisHomePage extends AdStatefulWidget {
  ConsultaNisHomePage({Key? key})
      : super(key: key, name: 'ConsultaNisHomePage');

  @override
  State<ConsultaNisHomePage> createState() => _ConsultaNisHomePageState();
}

class _ConsultaNisHomePageState extends State<ConsultaNisHomePage> {
  final ConsultaNisController _controller = ConsultaNisController();

  @override
  void initState() {
    _controller.init();
    super.initState();
  }

  List<CardFeature> get gridItens => [
        CardFeature(
          label: 'Consultar NIS pelo\nsite CNIS',
          prefix: Symbols.public,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, ConsultaNisSiteCnisPage())),
        ),
        CardFeature(
          label: 'Consultar NIS pelo\nsite Meu INSS',
          prefix: Symbols.public,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, ConsultaNisSiteMeuInssPage())),
        ),
        CardFeature(
          label: 'Consultar NIS pelo\nCartão Cidadão',
          prefix: Symbols.credit_card,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, ConsultaNisCartaoCidadaoPage())),
        ),
        CardFeature(
          label: 'Consultar NIS por\nTelefone',
          prefix: Symbols.call_quality,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, ConsultaNisTelefonePage())),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(
        AppButton.ad(
          onTap: () => _controller.onClickConsultar(context),
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
          title: 'Consultar NIS com CPF',
          desc: 'Digite seu CPF no campo abaixo para buscar seu NIS.',
        ),
        AppField(
          controller: model.cpf,
          label: 'CPF',
          hint: '000.000.000-00',
          onChanged: (e) => _controller.consultaNistream.update(),
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
