import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/header_hero.dart';
import 'package:benefits_brazil/app/core/components/in_footer_cta.dart';
import 'package:benefits_brazil/app/core/components/section_header_sm.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/vale_gas/has_rights/ui/vale_gas_has_rights_home_page.dart';
import 'package:flutter/material.dart';

class ValeGasHowWorkValuesAvailablePage extends JourneyStatefulWidget {
  const ValeGasHowWorkValuesAvailablePage({super.key})
      : super(name: 'ValeGasHowWorkValuesAvailablePage');

  @override
  State<ValeGasHowWorkValuesAvailablePage> createState() => _BfHowWorkValuesAvailablePage();
}

class _BfHowWorkValuesAvailablePage extends State<ValeGasHowWorkValuesAvailablePage> {
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
              HeaderHero(
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/Vale-gas-dinheiro.jpg',
                title: 'Quais valores estão disponíveis?',
                desc:
                    'O pagamento do Vale-gás poderá ser acumulado com outros benefícios, auxílios e bolsas dos cadastrados no Programa Auxílio Brasil, agora chamado de Vale Gás.',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              const SectionHeaderSm('Valores disponíveis',
                  'O valor pago do Auxílio Gás, em 2023, corresponde a 100% da média do valor nacional do botijão de cozinha.\n\nDesse modo, o benefício é reajustado de acordo com as alterações que ocorrem no valor do gás de cozinha.\n\nInicialmente, o programa foi criado para oferecer uma quantia de 50% do valor do gás de cozinha, e permaneceu assim nos meses de janeiro, fevereiro, abril e junho de 2022.\n\nJá entre os meses de agosto e dezembro, as famílias foram contempladas com o valor integral da média nacional do botijão de 13kg.'),
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
