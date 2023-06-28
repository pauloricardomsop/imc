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
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class ConferirValoresPage extends JourneyStatefulWidget {
  const ConferirValoresPage({Key? key}) : super(key: key, name: 'ConferirValoresPage');

  @override
  State<ConferirValoresPage> createState() => ConferirValoresPageState();
}

class ConferirValoresPageState extends State<ConferirValoresPage> {
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
                title: 'Como conferir os valores a receber de um falecido?',
                desc:
                    'Na sequência, o sistema vai mostrar a "Lista de valores do falecido". Além da faixa de valores disponíveis, também são informados o nome da instituição, origem do valor e dados de contato. No caso de falecidos, não é possível solicitar os valores pelo sistema do SVR. É preciso que o solicitante entre em contato com as empresas que constam na lista. O próprio sistema disponibiliza telefone e email de contato em "dados de contato"',
              ),
              const H(16),
              const AppImage(
                  url:
                      'https://ldcapps.com/wp-content/uploads/2023/04/Como-conferir-os-valores-a-receber-de-um-falecido.png'),
              const H(16),
              Text(
                'Não é especificado prazo para atendimento dos pedidos pelas empresas, diferente de outros casos no qual os bancos precisam devolver o dinheiro esquecido em até 12 dias. "Como a solicitação não ocorre diretamente via sistema, não se aplica o prazo regulamentar de 12 dias úteis e, portanto, o prazo depende do acordado entre as partes", afirma o Banco Central.',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
              const H(32),
              Text(
                'Veja mais',
                style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  InFooterCta _inFooterCta() {
    return InFooterCta(
      onTap: () => AdController.showInterstitialTransitionAd(
        context,
          onComplete: () =>
              push(context, const WebViewPage('https://valoresareceber.bcb.gov.br/publico'))),
      label: 'CONSULTAR VALORES',
      invert: true,
      icon: const AdIcon(),
    );
  }
}
