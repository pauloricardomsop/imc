import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/enums/consulta_valores_tipo.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_svr/ui/consultar_svr_form_page.dart';

class ConsultaValoresHomePage extends AdStatefulWidget {
  final ConsultaValoresPessoaEstado estado;
  ConsultaValoresHomePage(this.estado, {Key? key})
      : super(key: key, name: 'ConsultaValoresReceberHomePage');

  @override
  State<ConsultaValoresHomePage> createState() =>
      ConsultaValoresReceberHomePageState();
}

class ConsultaValoresReceberHomePageState
    extends State<ConsultaValoresHomePage> {
  List<CardFeature> get cardFeatureItens => [
        CardFeature(
          label: 'Consulta Pessoa\nFísica',
          prefix: Symbols.group,
          onTap: () => push(
              context,
              ConsultaValoresFormPage(
                  widget.estado, ConsultaValoresPessoa.fisica)),
        ),
        CardFeature(
          label: 'Consulta Pessoa\nJurídica',
          prefix: Symbols.domain,
          onTap: () => push(
              context,
              ConsultaValoresFormPage(
                  widget.estado, ConsultaValoresPessoa.juridica)),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: AppColors.surfaceContainer,
      child: AppListView(
        children: [
          const Header.text('Consulte seus valores\na receber',
              'Descubra se você tem valores esquecidos em instituições financeiras.'),
          CardFeatures(cardFeatureItens),
        ],
      ),
    );
  }
}
