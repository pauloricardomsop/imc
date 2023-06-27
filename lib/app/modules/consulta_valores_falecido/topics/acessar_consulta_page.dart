import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/ad_icon.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_image.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/check_list.dart';
import 'package:svr/app/core/components/exit_banner.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/components/web_view_page.dart';
import 'package:svr/app/core/models/check_list_model.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class AcessarConsultaPage extends JourneyStatefulWidget {
  const AcessarConsultaPage({Key? key}) : super(key: key, name: 'AcessarConsultaPage');

  @override
  State<AcessarConsultaPage> createState() => AcessarConsultaStatePage();
}

class AcessarConsultaStatePage extends State<AcessarConsultaPage> {
  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    super.initState();
  }

  List<CheckListModel> get checkList => [
        CheckListModel(
            icon: Icons.arrow_forward,
            label:
                'Acesse o site oficial do Banco Central pelo link valoresareceber.bcb.gov.br ou clicando no botão abaixo.'),
        CheckListModel(
            icon: Icons.arrow_forward,
            label: 'Em seguida, digite o CPF e a data de nascimento da pessoa falecida;'),
      ];

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
                title: 'Como acessar a consulta do SVR',
                desc:
                    'Para acessar a consulta do Sistema de Valores a Receber, disponibilizamos o seguinte passo a passo.',
              ),
              const H(16),
              CheckList(checkList),
              const H(16),
              const AppImage(
                  url:
                      'https://ldcapps.com/wp-content/uploads/2023/04/Como-acessar-a-consulta-do-SVR.png',
                  height: 550),
            ],
          ),
        ),
        const H(160),
      ],
    );
  }

  InFooterCta _inFooterCta() {
    return InFooterCta(
      onTap: () => push(
          context,
          ExitBanner(
            widget.name,
            title: 'Consulta de valores a receber do BACEN',
            buttonLabel: 'CONSULTAR VALORES',
            buttonSubLabel: 'Após o anúncio você terá acesso ao formulário de valores a receber:  ',
            buttonSubLabelBold: 'https://valoresareceber.bcb.gov.br/publico',
            onClick: () => AdController.showRewardTransitionAd(
          onComplete: () =>
              push(context, const WebViewPage('https://valoresareceber.bcb.gov.br/publico'))),
          )),
      label: 'CONSULTAR VALORES',
      invert: true,
      icon: const AdIcon(),
    );
  }
}
