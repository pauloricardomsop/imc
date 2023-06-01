import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_card_grid.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/card_sm.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/w.dart';
import 'package:svr/app/core/models/card_grid_model.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_valores/consulta_valores_page.dart';
import 'package:svr/app/modules/consulta_valores_falecido/consulta_valores_falecido_page.dart';
import 'package:svr/app/modules/home/topics/aumentar_nivel_page.dart';
import 'package:svr/app/modules/home/topics/como_receber_page.dart';
import 'package:svr/app/modules/home/topics/como_saber_page.dart';
import 'package:svr/app/modules/home/topics/oque_e_page.dart';

import '../../core/components/exit_banner.dart';
import '../../core/components/label_double_column.dart';

class HomePage extends JourneyStatefulWidget {
  const HomePage({Key? key}) : super(key: key, name: 'HomePage');

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchInterstitialTransitionAd(AdController.adConfig.intersticialTransition.id);
    AdController.fetchRewardTransitionAd(AdController.adConfig.rewardedTransition.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    AdController.fetchRewardAd();
    super.initState();
  }

  List<CardGridModel> get gridItens => [
        CardGridModel(
          title: 'Consulta Valores a\nReceber',
          icon: Icons.payments_outlined,
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const ConsultaValoresPage())),
        ),
        CardGridModel(
          title: 'Consulta Valores\nde Falecidos',
          icon: Icons.account_balance,
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const ConsultaValoresFalecidoPage())),
        )
      ];

  List<CardSm> get itens => [
        CardSm(
          title: 'O que é o Sistema Valores a Receber',
          subtitle: 'Saiba o que é e como funciona.',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const OqueEPage())),
        ),
        CardSm(
          title: 'O que é conta Prata e Ouro do GOV.BR',
          subtitle: 'Veja como aumentar o nível da sua conta .GOV',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const AumentarNivelPage())),
        ),
        CardSm(
          title: 'Como saber se tenho valores a receber?',
          subtitle: 'Saiba como consultar seu saldo.',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const ComoSaberPage())),
        ),
        CardSm(
          title: 'Como vou receber meus valores?',
          subtitle: 'Aprenda quais as opções de recebimento.',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const ComoReceberPage())),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      onWillPop: () async => push(context, const HomeExitBanner()),
      active: AdController.adConfig.banner.active,
      behavior: [widget.name],
      child: body(context),
    );
  }

  Widget body(_) {
    return AppListView(
      padding: const EdgeInsets.all(16),
      children: [
        const LabelDoubleColumn('Opções de', 'Consulta'),
        const H(8),
        Row(
          children: [
            Expanded(child: AppCardGrid(gridItens[0])),
            const W(8),
            Expanded(child: AppCardGrid(gridItens[1])),
          ],
        ),
        const H(32),
        AppBannerAd(AdBannerStorage.get(widget.name)),
        const H(32),
        const LabelDoubleColumn('Conteúdos', 'Valores a Receber'),
        const H(8),
        ...itens
      ],
    );
  }
}
