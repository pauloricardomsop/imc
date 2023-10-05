import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/modules/estatisticas/estatisticas_model.dart';

class EstatisticasDetalhesPage extends AdStatefulWidget {
  EstatisticasDetalhesPage({Key? key})
      : super(key: key, name: 'EstatisticasDetalhesPage');

  @override
  State<EstatisticasDetalhesPage> createState() => EstatisticasPageState();
}

class EstatisticasPageState extends State<EstatisticasDetalhesPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        backgroundColor: const Color(0xFFEEF5FE),
        child: AppListView(
          children: [
            const Header(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderTitle(
                    'Detalhes',
                    color: Color(0xFF172554),
                  ),
                  H(12),
                  AppTitle(
                    'Valores disponíveis',
                    color: Color(0xFF172554),
                  ),
                  H(4),
                  AppDesc(
                    'Total de valores que ainda não foram resgatados.',
                    color: Color(0xFF172554),
                  ),
                ],
              ),
            ),
            TableValues(
              left: 'DATA',
              right: 'HORÁRIO',
              models: EstatisticasValores
                  .estatisticasValores.estatisticas!.proximasDivulgacoes!
                  .map((e) =>
                      TableValuesModel(label: e.data!, value: e.horario!))
                  .toList(),
            )
          ],
        ));
  }
}
