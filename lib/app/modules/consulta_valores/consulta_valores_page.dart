import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_valores/consulta_valores_pessoa_tipo_page.dart';

class ConsultaValoresPage extends JourneyStatefulWidget {
  const ConsultaValoresPage({Key? key}) : super(key: key, name: 'ConsultaValresPage');

  @override
  State<ConsultaValoresPage> createState() => ConsultaValoresPageState();
}

class ConsultaValoresPageState extends State<ConsultaValoresPage> {
  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
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
        bottom: _inFooterCta(),
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
                  const HeaderHero(
                    title: 'Passo a passo para consultar e resgatar valores a receber.',
                    desc:
                        'O sistema de valores a receber começou a sua segunda fase em 7 de Março de 2023.\n\nNesta segunda fase, é possível consultar novos valores, para você ou para falecidos.\n\nO SVR está com um novo sistema de consulta. Veja o passo a passo de como consultar e dicas importantes.',
                  ),
                  const H(24),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  InFooterCta _inFooterCta() {
    return InFooterCta(
      onTap: () => AdController.showInterstitialTransitionAd(context,
          onComplete: () => push(context, const ConsultaValoresPessoaTipoPage())),
      label: 'VER PASSO A PASSO',
      invert: true,
      icon: Icons.arrow_forward,
    );
  }
}
