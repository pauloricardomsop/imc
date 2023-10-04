import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/enums/consulta_valores_tipo.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_valores_receber/ui/consulta_valores_form_page.dart';

class ConsultaValoresHomePage extends AdStatefulWidget {
  ConsultaValoresHomePage({Key? key}) : super(key: key, name: 'ConsultaValoresReceberHomePage');

  @override
  State<ConsultaValoresHomePage> createState() => ConsultaValoresReceberHomePageState();
}

class ConsultaValoresReceberHomePageState extends State<ConsultaValoresHomePage> {
  List<CardFeature> get cardFeatureItens => [
        CardFeature(
          label: 'Consulta Pessoa\nFísica',
          prefix: Symbols.group,
          onTap: () => push(context, ConsultaValoresFormPage(ConsultaValoresPessoa.fisica)),
        ),
        CardFeature(
          label: 'Consulta Pessoa\nJurídica',
          prefix: Symbols.domain,
          onTap: () => push(context, ConsultaValoresFormPage(ConsultaValoresPessoa.juridica)),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: AppColors.surfaceContainer,
      child: AppListView(
        children: [
          const Header(
            top: HeaderTop(backgroundColor: AppColors.surfaceContainer, leading: AppIcon.backLight(backgroundColor: AppColors.surfaceContainerHigh)),
            backgroundColor: AppColors.surfaceContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderTitle('Consulte seus valores\na receber', color: AppColors.onSurface),
                H(16),
                HeaderDesc('Consulte se você possui valores a receber pelo sistema do Banco Central.', color: AppColors.onSurface),
              ],
            ),
          ),
          CardFeatures(cardFeatureItens),
        ],
      ),
    );
  }
}
