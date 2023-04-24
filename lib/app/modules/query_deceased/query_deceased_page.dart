import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/ad_icon.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/button_icon.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/query_deceased/query_deceased_detailed_page.dart';

class QueryDeceasedPage extends JourneyStatefulWidget {
  const QueryDeceasedPage({Key? key}) : super(key: key, name: 'QueryDeceasedPage');

  @override
  State<QueryDeceasedPage> createState() => _QueryDeceasedPageState();
}

class _QueryDeceasedPageState extends State<QueryDeceasedPage> {
  @override
  void initState() {
    AdController.fetchIntersticialRewardTransitionAd(
        AdController.adConfig.intersticialRewardedTransition.id);
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
      child: body(context),
    );
  }

  Widget body(_) {
    return Column(
      children: [
        const BackHeader(),
        AppListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppBannerAd(AdBannerStorage.get(widget.name)),
            const H(32),
            const HeaderHero(
              title: 'Consulta de Valores a Receber de Falecidos.',
              desc:
                  'Veja o passo a passo de como consultar e como resgatar valores a receber de falecidos. Importante ressaltar que você deve ser herdeiro, inventariante, testamentário ou representante legal.',
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ButtonIcon(
            label: 'Ver passo a passo',
            invert: true,
            widget: const AdIcon(),
            onTap: () => AdController.showRewardAd(
                onComplete: () => push(context, const QueryDeceasedDetailedPage())),
          ),
        )
      ],
    );
  }
}
