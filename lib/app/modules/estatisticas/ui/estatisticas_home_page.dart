import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/card_valor.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/components/table_values.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/estatisticas/estatisticas_model.dart';
import 'package:svr/app/modules/estatisticas/ui/estatisticas_detalhes_page.dart';
import 'package:svr/app/modules/estatisticas/ui/estatisticas_proximas_divulgacoes_bottom.dart';

class EstatisticasHomePage extends JourneyStatefulWidget {
  const EstatisticasHomePage({Key? key}) : super(key: key, name: 'EstatisticasPage');

  @override
  State<EstatisticasHomePage> createState() => EstatisticasPageState();
}

class EstatisticasPageState extends State<EstatisticasHomePage> {
  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: [widget.name],
        bottom: InFooterCta(
          onTap: () => showModalBottomSheet(
              context: context,
              builder: (_) => const EstatisticasProximasDivulgacoesBottom(),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ))),
          label: 'CALENDÁRIO DE DIVULGAÇÕES',
          invert: true,
          icon: Icons.arrow_forward,
        ),
        child: body(context));
  }

  Widget body(_) {
    return Stack(
      children: [
        AppListView(
          padding: EdgeInsets.zero,
          children: [
            const BackHeader(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBannerAd(AdBannerStorage.get(widget.name)),
                  const H(16),
                  CardValor(
                    title: EstatisticasValores
                        .estatisticasValores.estatisticas!.home!.cardValores!.title!,
                    value: EstatisticasValores
                        .estatisticasValores.estatisticas!.home!.cardValores!.value!,
                    desc: EstatisticasValores
                        .estatisticasValores.estatisticas!.home!.cardValores!.desc!,
                    onClick: () => push(context, const EstatisticasDetalhesPage()),
                  ),
                  const H(16),
                  const HeaderHero(
                    title: 'Valores Devolvidos',
                    desc: 'Todos os meses mais valores estão disponíveis, fique atento.',
                  ),
                  const H(16),
                  TableValues(
                    left: 'ANO - MÊS',
                    right: 'VALOR DEVOLVIDO',
                    models: EstatisticasValores
                        .estatisticasValores.estatisticas!.home!.valoresDevolvidos!
                        .map((e) =>
                            EstatisticaValorModel(label: e.anoMes!, value: e.valorDevolvido!))
                        .toList(),
                  ),
                  const H(16),
                  Center(
                    child: Text(
                      'Fonte: bcb.gov.br\nMês de ref.: Maio - 2023',
                      style: AppTheme.text.normal.sm(const Color(0xFF777777)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
