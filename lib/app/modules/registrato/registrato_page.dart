import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
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
import 'package:svr/app/modules/registrato/topics/registrato_chave_pix_page.dart';
import 'package:svr/app/modules/registrato/topics/registrato_contas_relacionamentos_page.dart';
import 'package:svr/app/modules/registrato/topics/registrato_emprestimo_financiamento_page.dart';

class RegistratoPage extends JourneyStatefulWidget {
  const RegistratoPage({Key? key}) : super(key: key, name: 'RegistratoPage');

  @override
  State<RegistratoPage> createState() => RegistratoPageState();
}

class RegistratoPageState extends State<RegistratoPage> {
  List<AppCardModel> get cardItens => [
        AppCardModel(
          icon: Symbols.currency_exchange,
          title: 'Empréstimos e Financiamentos',
          subtitle: 'Feitos em seu nome',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const RegistratoEmprestimoFinanciamentoPage())),
        ),
        AppCardModel(
          icon: Symbols.account_balance,
          title: 'Contas e Relacionamentos',
          subtitle: 'Suas contas bancárias',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const RegistratoContasRelacionamentoPage())),
        ),
        AppCardModel(
          icon: Icons.pix_outlined,
          title: 'Chaves PIX',
          subtitle: 'Veja todas as chaves PIX cadastradas em seu nome.',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context,const  RegistratoChavePixPage())),
        ),
      ];
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
                    title: 'Registrato Banco Central',
                    desc:
                        'No site do Banco Central você vai encontrar os serviços abaixo, saiba mais sobre cada um deles.',
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
