import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_card.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_valores/consulta_valores_pessoa_fisica_page.dart';
import 'package:svr/app/modules/consulta_valores/consulta_valores_pessoa_juridica_page.dart';

class ConsultaValoresPessoaTipoPage extends JourneyStatefulWidget {
  const ConsultaValoresPessoaTipoPage({Key? key})
      : super(key: key, name: 'ConsultaValoresPessoaTipoPage');

  @override
  State<ConsultaValoresPessoaTipoPage> createState() => ConsultaValoresPessoaTipoPageState();
}

class ConsultaValoresPessoaTipoPageState extends State<ConsultaValoresPessoaTipoPage> {
  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    super.initState();
  }

  List<AppCardModel> get cardItens => [
        AppCardModel(
          //TODO: AJustar ícone
          icon: Icons.contact_support_outlined,
          title: 'Valores a Receber de Pessoa Física',
          subtitle: 'Necessário ter CPF',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const ConsultaValoresPessoaFisicaPage())),
        ),
        AppCardModel(
          icon: Icons.domain,
          title: 'Valores a Receber de Pessoa Jurídica',
          subtitle: 'Necessário ter CNPJ',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const ConsultaValoresPessoaJuridicaPage())),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        active: AdController.adConfig.banner.active, behavior: [widget.name], child: body(context));
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
                    title: 'Antes de iniciar...',
                    desc:
                        'Você pode consultar valores a receber de Pessoas Físicas ou Jurídicas. Escolha abaixo uma das opções de consulta.',
                  ),
                  const H(16),
                  AppCardList(cardItens)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
