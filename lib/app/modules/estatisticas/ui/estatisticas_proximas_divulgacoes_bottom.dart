import 'package:flutter/material.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/table_values.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/estatisticas/estatisticas_model.dart';

List<EstatisticaValorModel> valoresDevolvidos = [
  EstatisticaValorModel(label: '07 DE JUNHO', value: '14:30'),
  EstatisticaValorModel(label: '07 DE JULHO', value: '14:30'),
  EstatisticaValorModel(label: '07 DE AGOSTO', value: '14:30'),
  EstatisticaValorModel(label: '07 DE SETEMBRO', value: '14:30'),
  EstatisticaValorModel(label: '07 DE OUTUBRO', value: '14:30'),
  EstatisticaValorModel(label: '07 DE NOVEMBRO', value: '14:30'),
  EstatisticaValorModel(label: '07 DE DEZEMBOR', value: '14:30'),
];

class EstatisticasProximasDivulgacoesBottom extends JourneyStatefulWidget {
  const EstatisticasProximasDivulgacoesBottom({Key? key})
      : super(key: key, name: 'EstatisticasProximasDivulgacoesBottom');

  @override
  State<EstatisticasProximasDivulgacoesBottom> createState() =>
      EstatisticasProximasDivulgacoesBottomState();
}

class EstatisticasProximasDivulgacoesBottomState
    extends State<EstatisticasProximasDivulgacoesBottom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 33,
              height: 7,
              decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(100)),
            ),
          ),
          const H(16),
          Text(
            'Próximas\nDivulgações',
            textAlign: TextAlign.center,
            style: AppTheme.text.extra.xl3(const Color(0xFF1B1C1C)),
          ),
          const H(16),
          Expanded(
            child: TableValues(
              left: 'DATA',
              right: 'HORÁRIO',
              models: EstatisticasValores.estatisticasValores.estatisticas!.proximasDivulgacoes!
                  .map((e) => EstatisticaValorModel(label: e.data!, value: e.horario!))
                  .toList(),
              listable: true,
            ),
          ),
        ],
      ),
    );
  }
}
