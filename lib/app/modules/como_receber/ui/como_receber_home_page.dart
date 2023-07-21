import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/como_receber/como_receber_controller.dart';
import 'package:svr/app/modules/como_receber/como_receber_model.dart';
import 'package:svr/app/modules/como_receber/ui/como_receber_cpf_data_page.dart';

class ComoReceberHomePage extends JourneyStatefulWidget {
  const ComoReceberHomePage({Key? key}) : super(key: key, name: 'ComoReceberHomePage');

  @override
  State<ComoReceberHomePage> createState() => _ComoReceberHomePageState();
}

class _ComoReceberHomePageState extends State<ComoReceberHomePage> {
  @override
  void initState() {
    AdController.fetchRewardAd();
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
      bottom: InFooterCta(
        onTap: () => AdController.showInterstitialTransitionAd(context, onComplete: () {
          ComoReceberController().comoReceberQuizStream.add(ComoReceberQuiz());
          push(context, const ComoReceberCpfDataPage());
        }),
        label: 'VERIFICAR VALORES',
      ),
      child: body(context),
    );
  }

  Widget body(_) {
    return Column(
      children: [
        const BackHeader(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              const HeaderHero(
                title: 'Questionário para verificar como receber dinheiro esquecido.',
                desc:
                    'Veja o que você precisa para verificar se você possui dinheiro esquecido nos bancos e saiba como receber esse dinheiro pelo sistema do Banco Central.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
