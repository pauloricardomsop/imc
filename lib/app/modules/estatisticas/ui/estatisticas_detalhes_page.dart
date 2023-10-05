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
            Header(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderTitle(
                    'Detalhes',
                    color: Color(0xFF172554),
                  ),
                  const H(12),
                  const AppTitle(
                    'Valores disponíveis',
                    color: Color(0xFF172554),
                  ),
                  const H(4),
                  const AppDesc(
                    'Total de valores que ainda não foram resgatados.',
                    color: Color(0xFF172554),
                  ),
                  const H(24),
                  CardValor(
                    title: EstatisticasValores.estatisticasValores.estatisticas!
                        .detalhes!.cardValoresReceber!.title!,
                    value: EstatisticasValores.estatisticasValores.estatisticas!
                        .detalhes!.cardValoresReceber!.value!,
                    desc: EstatisticasValores.estatisticasValores.estatisticas!
                        .detalhes!.cardValoresReceber!.desc!,
                  ),
                  const H(24),
                  TableValues(
                    left: 'DESCRIÇÃO',
                    right: 'VALOR',
                    hasBlur: false,
                    rightItemStyle:
                        const TextStyle(color: Color(0xFF076046)).titleMedium,
                    itens: EstatisticasValores.estatisticasValores.estatisticas!
                        .detalhes!.valoresReceber!
                        .map((e) => TableValuesModel(
                            label: e.descricao!,
                            value: e.valor!,
                            desc: e.subtitle))
                        .toList(),
                  )
                ],
              ),
            ),
            const AppTitle(
              'Valores disponíveis',
              color: Color(0xFF172554),
            ),
            const H(4),
            const AppDesc(
              'Total de valores que ainda não foram resgatados.',
              color: Color(0xFF172554),
            ),
            const H(24),
            CardValor(
              title: EstatisticasValores.estatisticasValores.estatisticas!
                  .detalhes!.cardValoresDevolvidos!.title!,
              value: EstatisticasValores.estatisticasValores.estatisticas!
                  .detalhes!.cardValoresDevolvidos!.value!,
              desc: EstatisticasValores.estatisticasValores.estatisticas!
                  .detalhes!.cardValoresDevolvidos!.desc!,
            ),
            const H(24),
            TableValues(
              left: 'DESCRIÇÃO',
              right: 'VALOR',
              rightItemStyle:
                  const TextStyle(color: Color(0xFF076046)).titleMedium,
              itens: EstatisticasValores.estatisticasValores.estatisticas!
                  .detalhes!.valoresDevolvidos!
                  .map((e) => TableValuesModel(
                      label: e.descricao!, value: e.valor!, desc: e.subtitle))
                  .toList(),
            )
          ],
        ));
  }
}
