import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/modules/estatisticas/estatisticas_model.dart';

class EstatisticasValoresDevolvidosPage extends AdStatefulWidget {
  EstatisticasValoresDevolvidosPage({Key? key})
      : super(key: key, name: 'EstatisticasValoresDevolvidosPage');

  @override
  State<EstatisticasValoresDevolvidosPage> createState() =>
      EstatisticasPageState();
}

class EstatisticasPageState extends State<EstatisticasValoresDevolvidosPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        backgroundColor: const Color(0xFFEEF5FE),
        child: AppListView(
          children: [
            const Header.text(
              'Próximas\nDivulgações',
              'Todos os meses mais valores estão disponíveis, fique atento.',
            ),
            TableValues(
              left: 'DATA',
              right: 'HORÁRIO',
              itens: EstatisticasValores
                  .estatisticasValores.estatisticas!.proximasDivulgacoes!
                  .map((e) =>
                      TableValuesModel(label: e.data!, value: e.horario!))
                  .toList(),
            )
          ],
        ));
  }
}
