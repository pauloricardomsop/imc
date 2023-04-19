import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/button_icon.dart';
import 'package:svr/app/core/components/card_sm.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/utils/global_resource.dart';
// import 'package:svr/app/modules/what_is/what_is/what_is_know_receive_page.dart';

class WhatIsNewsPage extends JourneyStatefulWidget {
  const WhatIsNewsPage({Key? key}) : super(key: key, name: 'WhatIsNewsPage');

  @override
  State<WhatIsNewsPage> createState() => WhatIsNewsPageState();
}

class WhatIsNewsPageState extends State<WhatIsNewsPage> {
  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get('${widget.name}1'),
    );
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get('${widget.name}2'),
    );
    super.initState();
  }

  List<CardSm> get itens => [
        CardSm(
          title: 'Como sei se tenho valores a receber?',
          subtitle: 'Aprenda como o sistema funciona e saiba se tem valores pra receber.',
          onTap: () {
            Navigator.pop(context);
            // push(context, const WhatIsKnowReceivePage());
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      active: AdController.adConfig.banner.active,
      behavior: ['${widget.name}1', '${widget.name}2'],
      child: body(context),
    );
  }

  Widget body(_) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        BackHeader(
          button: ButtonIconSmall(
            onTap: () {
              Navigator.pop(context);
              // push(context, const WhatIsKnowReceivePage());
            },
            icon: Icons.arrow_forward_ios,
            label: 'Próximo',
            invert: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBannerAd(AdBannerStorage.get('${widget.name}1')),
              const H(16),
              const HeaderHero(
                title: 'Quais são as novidades do SVR em 2023?',
                desc:
                    'As novas regras do SVR fornecidas pelo Banco Central (BC) buscam aprimorar o acesso às poupanças e contas inativas.',
              ),
              const H(16),
              const HeaderHero(
                desc:
                    'Com isso, ficou mais fácil para os cidadãos acessarem o seu dinheiro e requisitar o saque no próprio dia da consulta, dispensando o agendamento feito pelo próprio sistema.\n\nAlém disso, o BC também vai divulgar informações sobre valores de falecidos, para que os herdeiros possam ter acesso ao valor.',
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/documentos-necessarios.jpg',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get('${widget.name}2')),
              const H(32),
              ...itens,
              const H(24),
            ],
          ),
        ),
      ],
    );
  }
}
