import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/ad_icon.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/button_icon.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/query/query_detailed_page.dart';

class QueryPage extends JourneyStatefulWidget {
  const QueryPage({Key? key}) : super(key: key, name: 'QueryPage');

  @override
  State<QueryPage> createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
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
    return WillPopScope(
      onWillPop: () async => false,
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: [widget.name],
        body: body(context),
      ),
    );
  }

  Widget body(_) {
    return Column(
      children: [
        const BackHeader(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              const HeaderHero(
                title: 'Consulta de Valores a Receber',
                desc:
                    'Veja o passo a passo de como consultar e como resgatar valores a receber, seja para sua pessoa física ou pessoa jurídica.',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ButtonIcon(
            label: 'Ver passo a passo',
            invert: true,
            icon: const AdIcon(),
            onTap: () => AdController.showRewardAd(
                onComplete: () => push(context, const QueryDetailedPage())),
          ),
        )
      ],
    );
  }
}
