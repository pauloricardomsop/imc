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
import 'package:svr/app/modules/what_is_how_work/what_is_how_work_home_page.dart';

import '../../../core/components/label_double_column.dart';

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
    super.initState();
  }

  List<CardGridModel> get gridItens => [
        CardGridModel(
          title: 'Consulta\nValores a \nReceber',
          icon: Icons.payment,
          onTap: () {},
        ),
        CardGridModel(
          title: 'Consulta\nValores a \nReceber',
          icon: Icons.account_balance,
          onTap: () {},
        )
      ];

  List<CardSm> get itens => [
        CardSm(
          title: 'O que é e como funciona o  SVR.',
          subtitle: 'Entenda como funciona o Sistema de Valores a Receber.',
          onTap: () => push(context, const WhatIsHowWorkHomePage()),
        ),
        CardSm(
          title: 'Como aumentar o nível da minha conta Gov',
          subtitle: 'Saiba como consultar seu saldo.',
          onTap: () => push(context, Container()),
        ),
        CardSm(
          title: 'Resolvendo problemas no SVR',
          subtitle: 'Saiba como resolver os problemas frequentes do SVR.',
          onTap: () => push(context, Container()),
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
          image: 'https://ldcapps.com/wp-content/uploads/2023/03/documentos-necessarios.jpg',
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
