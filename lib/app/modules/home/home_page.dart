import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_card_grid.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/card_sm.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/w.dart';
import 'package:svr/app/core/models/card_grid_model.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/home/topics/account_silver_gold.dart';
import 'package:svr/app/modules/home/topics/how_receive_page.dart';
import 'package:svr/app/modules/home/topics/know_receive_page.dart';
import 'package:svr/app/modules/home/topics/what_is_page.dart';
import 'package:svr/app/modules/query/query_page.dart';

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
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    AdController.fetchRewardAd();
    super.initState();
  }

  List<CardGridModel> get gridItens => [
        CardGridModel(
          title: 'Consulta\nValores a \nReceber',
          icon: Icons.payments_outlined,
          onTap: () => push(context, const QueryPage()),
        ),
        CardGridModel(
          title: 'Consulta\nValores de\nFalecidos',
          icon: Icons.account_balance,
          onTap: () {},
        )
      ];

  List<CardSm> get itens => [
        CardSm(
          title: 'O que é o Sistema Valores a Receber',
          subtitle: 'Saiba o que é e como funciona.',
          onTap: () => push(context, const WhatIsPage()),
        ),
        CardSm(
          title: 'O que é conta Prata e Ouro do GOV.BR',
          subtitle: 'Veja como aumentar o nível da sua conta .GOV',
          onTap: () => push(context, const AccountSilverGoldPage()),
        ),
        CardSm(
          title: 'Como saber se tenho valores a receber?',
          subtitle: 'Saiba como consultar seu saldo.',
          onTap: () => push(context, const KnowReceivePage()),
        ),
        CardSm(
          title: 'Como vou receber meus valores?',
          subtitle: 'Aprenda quais as opções de recebimento.',
          onTap: () => push(context, const HowReceivePage()),
        ),
      ];

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
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppBannerAd(AdBannerStorage.get(widget.name)),
        const H(32),
        const HeaderHero(
          image: 'https://ldcapps.com/wp-content/uploads/2023/04/homeBanner.png',
        ),
        Row(
          children: [
            Expanded(child: AppCardGrid(gridItens[0])),
            const W(8),
            Expanded(child: AppCardGrid(gridItens[1])),
          ],
        ),
        const H(32),
        const LabelDoubleColumn('Conteúdos', 'Valores a Receber'),
        const H(8),
        ...itens
      ],
    );
  }
}
