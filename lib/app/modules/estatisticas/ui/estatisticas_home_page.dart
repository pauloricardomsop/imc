import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/estatisticas/estatisticas_model.dart';
import 'package:svr/app/modules/estatisticas/ui/estatisticas_detalhes_page.dart';
import 'package:svr/app/modules/estatisticas/ui/estatisticas_proximas_divulgacoes_page.dart';
import 'package:svr/app/modules/estatisticas/ui/estatisticas_valores_devolvidos_page.dart';

class EstatisticasHomePage extends AdStatefulWidget {
  EstatisticasHomePage({Key? key}) : super(key: key, name: 'EstatisticasPage');

  @override
  State<EstatisticasHomePage> createState() => EstatisticasPageState();
}

class EstatisticasPageState extends State<EstatisticasHomePage> {
  List<CardFeature> get cardFeatures => [
        CardFeature(
          label: 'Valores que foram\ndevolvidos',
          prefix: Symbols.free_cancellation,
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () =>
                  push(context, EstatisticasValoresDevolvidosPage())),
        ),
        CardFeature(
          label: 'Próximas divulgações',
          prefix: Symbols.event_upcoming,
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () =>
                  push(context, EstatisticasProximasDivulgacoesPage())),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        child: AppListView(
      children: [
        Header(
          title: 'Estatísticas\ndo SVR',
          desc:
              'Fique de olho nas estatísticas para saber quando mais valores estarão disponíveis.',
          child: Column(
            children: [
              const H(16),
              CardValor(
                title: EstatisticasValores.estatisticasValores.estatisticas!
                    .home!.cardValores!.title!,
                value: EstatisticasValores.estatisticasValores.estatisticas!
                    .home!.cardValores!.value!,
                desc: EstatisticasValores
                    .estatisticasValores.estatisticas!.home!.cardValores!.desc!,
                onClick: () => AdManager.showIntersticial(context,
                    onDispose: () => push(context, EstatisticasDetalhesPage())),
              ),
            ],
          ),
        ),
        const AppTitle('Mais opções'),
        const H(4),
        const AppDesc(
            'Todos os meses mais valores estão disponíveis, fique atento.'),
        const H(24),
        CardFeatures(cardFeatures)
      ],
    ));
  }
}
