import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/header_hero.dart';
import 'package:benefits_brazil/app/core/components/in_footer_cta.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/vale_gas/has_rights/ui/vale_gas_has_rights_home_page.dart';
import 'package:flutter/material.dart';

class ValeGasHowWorkWhatIsPage extends JourneyStatefulWidget {
  const ValeGasHowWorkWhatIsPage({super.key}) : super(name: 'ValeGasHowWorkWhatIsPage');

  @override
  State<ValeGasHowWorkWhatIsPage> createState() => _BfHowWorkWhatIsPage();
}

class _BfHowWorkWhatIsPage extends State<ValeGasHowWorkWhatIsPage> {
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
        behavior: AdBannerStorage.get(widget.name),
        body: body(context),
      ),
    );
  }

  Widget body(_) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackHeaderBenefit(benefit: Benefit.valeGas),
              const H(32),
              const HeaderHero(
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/como-se-cadastrar-1.jpg',
                title: 'O que é o Vale Gás?',
                desc:
                    'O Auxílio Vale Gás 2023 é uma iniciativa do governo federal que visa proporcionar um desconto no preço do gás de cozinha para famílias de baixa renda.',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
            ],
          ),
        ),
        const H(16),
        InFooterCta(
          onTap: () {
            pops(context, 2);
            push(context, const ValeGasHasRightsHomePage());
          },
          icon: Icons.quiz_outlined,
          label: 'Quiz do Vale Gás',
        )
      ],
    );
  }
}
