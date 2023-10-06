import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/enums/consulta_valores_tipo.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_svr/ui/consultar_svr_form_page.dart';

class ConsultarSVRHomePage extends AdStatefulWidget {
  final ConsultaValoresPessoaEstado estado;
  ConsultarSVRHomePage(this.estado, {Key? key})
      : super(key: key, name: 'ConsultaValoresReceberHomePage');

  @override
  State<ConsultarSVRHomePage> createState() =>
      ConsultaValoresReceberHomePageState();
}

class ConsultaValoresReceberHomePageState extends State<ConsultarSVRHomePage> {
  List<CardFeature> get cardFeatureItens => [
        CardFeature(
          label: 'Consulta Pessoa\nFísica',
          prefix: Symbols.group,
          onTap: () => AdManager.showIntersticial(context, flow: AdFlow.going, onDispose: () => push(context, ConsultarSVRFormPage(widget.estado, ConsultaValoresPessoa.fisica))),
        ),
        CardFeature(
          label: 'Consulta Pessoa\nJurídica',
          prefix: Symbols.domain,
          onTap: () => AdManager.showIntersticial(context, flow: AdFlow.going, onDispose: () => push(context, ConsultarSVRFormPage(widget.estado, ConsultaValoresPessoa.juridica))),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: AppColors.surfaceContainer,
      child: AppListView(
        children: [
          const Header.text(
            'Consulte seus valores a receber',
            'Descubra se você tem valores esquecidos em instituições financeiras.',
          ),
          const H(16),
          CardFeatures(cardFeatureItens),
          const H(16),
          const BannerWidget(),
        ],
      ),
    );
  }
}
