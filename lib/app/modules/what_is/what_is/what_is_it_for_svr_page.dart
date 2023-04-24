import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_card_purple.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/button_icon.dart';
import 'package:svr/app/core/components/card_sm.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class WhatIsItForSvrPage extends JourneyStatefulWidget {
  const WhatIsItForSvrPage({Key? key}) : super(key: key, name: 'WhatIsItForSvrPage');

  @override
  State<WhatIsItForSvrPage> createState() => WhatIsItForSvrPageState();
}

class WhatIsItForSvrPageState extends State<WhatIsItForSvrPage> {
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
          title: 'Quais as novidades do SVR para 2023?',
          subtitle: 'Fique por dentro do que hà de novo no SVR.',
          onTap: () {
            Navigator.pop(context);
            // push(context, const WhatIsNewsPage());
          },
        ),
        CardSm(
          title: 'Como sei se tenho valores a receber?',
          subtitle: 'Aprenda como o sistema funciona e saiba se tem valores pra receber.',
          onTap: () {
            Navigator.pop(context);
            // push(context, WhatIsKnowReceivePage());
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
    return AppListView(
      padding: EdgeInsets.zero,
      children: [
        BackHeader(
          button: ButtonIconSmall(
            onTap: () {
              Navigator.pop(context);
              // push(context, const WhatIsNewsPage());
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
                title: 'O que é o Sistema de Valores a Receber ou SVR?',
                desc:
                    'O serviço serve para que pessoas físicas e jurídicas verificarem se têm valores a receber.',
              ),
              const H(16),
              const HeaderHero(
                desc:
                    'No sistema, você encontra informações de saldo credor de contas encerradas, parcelas de empréstimo e tarifas cobradas indevidamente, recursos não procurados após encerramento de grupos de consórcio, cotas de capital a devolver em cooperativas de crédito, entre outros, de entidades supervisionadas pelo Banco Central. Em caso positivo, a devolução destes recursos poderá ser requisitada.',
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/documentos-necessarios.jpg',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get('${widget.name}2')),
              const H(32),
              const AppCardPurple(
                  'Atenção: O Banco Central informou que não solicita confirmação de dados posteriormente e que somente a instituição ou banco que aparece na consulta do SVR pode entrar em contato com o cliente.'),
              const H(16),
              ...itens,
              const H(24),
            ],
          ),
        ),
      ],
    );
  }
}
