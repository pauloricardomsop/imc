import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/client/providers/portal_transparencia/models/bolsa_familia.dart';

import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/solucionando_divergencias/solucionando_divergencias_controller.dart';
import 'package:svr/app/modules/solucionando_divergencias/solucionando_divergencias_model.dart';
import 'package:svr/app/modules/solucionando_divergencias/ui/solucionando_divergencias_quantidade_filhos_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class SolucionandoDivergenciasHomePage extends AdStatefulWidget {
  final BolsaFamilia bolsaFamilia;
  SolucionandoDivergenciasHomePage(this.bolsaFamilia, {Key? key})
      : super(key: key, name: 'SolucionandoDivergenciasHomePage');

  @override
  State<SolucionandoDivergenciasHomePage> createState() =>
      _SolucionandoDivergenciasHomePageState();
}

class _SolucionandoDivergenciasHomePageState
    extends State<SolucionandoDivergenciasHomePage> {
  @override
  void initState() {
    SolucionandoDivergenciasController().quizStream.add(
        SolucionandoDivergenciasQuiz(double.parse(widget
            .bolsaFamilia.data.last.valorTotalPeriodo
            .replaceAll('R\$ ', '')
            .replaceAll(',', '.'))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(
        AppButton.forward(
          label: 'RESPONDER QUIZ',
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () => push(
                  context, SolucionandoDivergenciasQuantidadeFilhosPage())),
        ),
      ),
      child: body(context),
    );
  }

  Widget body(_) {
    return const AppListView(
      children: [
        Header.light(),
        HeaderTitle(
          'Solucionando divergências.',
          color: Color(0xFF020617),
        ),
        H(16),
        HeaderDesc(
          'É possível que o valor mostrado anteriormente, seja diferente do último valor que você recebeu.\n\nPara solucionar este conflito, responda a um questionário rápido  para identificar o valor correto do seu benefício.',
          color: Color(0xFF020617),
        )
      ],
    );
  }
}
