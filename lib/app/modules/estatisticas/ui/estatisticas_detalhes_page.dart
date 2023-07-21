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
import 'package:svr/app/core/components/table_values.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/estatisticas/estatisticas_model.dart';

List<EstatisticaValorModel> valoresReceber = [
  EstatisticaValorModel(
      label: 'PESSOA FÍSICA', value: 'R\$ 176M', desc: 'Quantidade de Beneficiários: 36.592.388'),
  EstatisticaValorModel(
      label: 'PESSOA JURÍDICA', value: 'R\$ 176M', desc: 'Quantidade de Beneficiários: 36.592.388'),
];

List<EstatisticaValorModel> valoresDevolvidos = [
  EstatisticaValorModel(
      label: 'PESSOA FÍSICA', value: 'R\$ 176M', desc: 'Quantidade de Beneficiários: 36.592.388'),
  EstatisticaValorModel(
      label: 'PESSOA JURÍDICA', value: 'R\$ 176M', desc: 'Quantidade de Beneficiários: 36.592.388'),
];

class EstatisticasDetalhesPage extends JourneyStatefulWidget {
  const EstatisticasDetalhesPage({Key? key}) : super(key: key, name: 'EstatisticasDetalhesPage');

  @override
  State<EstatisticasDetalhesPage> createState() => EstatisticasDetalhesPageState();
}

class EstatisticasDetalhesPageState extends State<EstatisticasDetalhesPage> {
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
      child: body(context),
    );
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
                  const HeaderHero(
                    title: 'Valores a Receber',
                    desc: 'Total de valores que ainda não foram resgatados.',
                  ),
                  const H(16),
                  CardValor(
                    title: EstatisticasValores
                        .estatisticasValores.estatisticas!.detalhes!.cardValoresReceber!.title!,
                    value: EstatisticasValores
                        .estatisticasValores.estatisticas!.detalhes!.cardValoresReceber!.value!,
                    desc: EstatisticasValores
                        .estatisticasValores.estatisticas!.detalhes!.cardValoresReceber!.desc!,
                  ),
                  const H(16),
                  TableValues(
                    left: 'DESCRIÇÃO',
                    right: 'VALOR',
                    models: EstatisticasValores
                        .estatisticasValores.estatisticas!.detalhes!.valoresReceber!
                        .map((e) => EstatisticaValorModel(
                            label: e.descricao!, value: e.valor!, desc: e.subtitle))
                        .toList(),
                  ),
                  const H(24),
                  const HeaderHero(
                    title: 'Valores Devolvidos',
                    desc: 'Total de valores que já foram resgatados.',
                  ),
                  const H(16),
                  CardValor(
                    title: EstatisticasValores
                        .estatisticasValores.estatisticas!.detalhes!.cardValoresDevolvidos!.title!,
                    value: EstatisticasValores
                        .estatisticasValores.estatisticas!.detalhes!.cardValoresDevolvidos!.value!,
                    desc: EstatisticasValores
                        .estatisticasValores.estatisticas!.detalhes!.cardValoresDevolvidos!.desc!,
                  ),
                  const H(16),
                  TableValues(
                    left: 'DESCRIÇÃO',
                    right: 'VALOR',
                    models: EstatisticasValores
                        .estatisticasValores.estatisticas!.detalhes!.valoresDevolvidos!
                        .map((e) => EstatisticaValorModel(
                            label: e.descricao!, value: e.valor!, desc: e.subtitle))
                        .toList(),
                  ),
                  const H(16),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
