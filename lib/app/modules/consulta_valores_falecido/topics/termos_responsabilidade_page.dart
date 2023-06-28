import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/ad_icon.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_image.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/components/web_view_page.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class TermosResponsabilidadePage extends JourneyStatefulWidget {
  const TermosResponsabilidadePage({Key? key})
      : super(key: key, name: 'TermosResponsabilidadePage');

  @override
  State<TermosResponsabilidadePage> createState() => TermosResponsabilidadePageState();
}

class TermosResponsabilidadePageState extends State<TermosResponsabilidadePage> {
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
      child: body(context),
    );
  }

  Widget body(_) {
    return AppListView(
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
                title: 'Saiba como concordar com os termos de responsabilidade.',
                desc:
                    'No próximo passo, é necessário concordar com um "Termo de Responsabilidade de acesso a dados de Terceiro". É preciso clicar na caixa ao lado esquerdo de "Aceito o termo de responsabilidade" e, depois, clicar no canto direito em "Confirmar". Não é possível passar para a próxima etapa sem concordar com o termo;',
              ),
              const H(16),
              const AppImage(
                  url:
                      'https://ldcapps.com/wp-content/uploads/2023/04/Saiba-como-concordar-com-os-termos-de-responsabilidade.png'),
              const H(32),
            ],
          ),
        ),
      ],
    );
  }

  InFooterCta _inFooterCta() {
    return InFooterCta(
      onTap: () => AdController.showInterstitialTransitionAd(context,
          onComplete: () =>
              push(context, const WebViewPage('https://valoresareceber.bcb.gov.br/publico'))),
      label: 'CONSULTAR VALORES',
      invert: true,
      icon: const AdIcon(),
    );
  }
}
