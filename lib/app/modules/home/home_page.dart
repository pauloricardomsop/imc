import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_card.dart';
import 'package:svr/app/core/components/app_card_grid.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/card_valor.dart';
import 'package:svr/app/core/components/divisor.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/w.dart';
import 'package:svr/app/core/models/card_grid_model.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/como_receber/ui/como_receber_home_page.dart';
import 'package:svr/app/modules/consulta_valores/consulta_valores_page.dart';
import 'package:svr/app/modules/consulta_valores_falecido/consulta_valores_falecido_page.dart';
import 'package:svr/app/modules/estatisticas/estatisticas_model.dart';
import 'package:svr/app/modules/estatisticas/ui/estatisticas_home_page.dart';
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
    AdController.fetchInterstitialTransitionAd(
        AdController.adConfig.intersticialTransition.id);
    AdController.fetchRewardTransitionAd(
        AdController.adConfig.rewardedTransition.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get('${widget.name}1'),
    );
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get('${widget.name}2'),
    );
    AdController.fetchRewardAd();
    super.initState();
  }

  List<CardGridModel> get gridItens => [
        CardGridModel(
          title: 'Consulta Valores a Receber',
          icon: Symbols.payments,
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const ConsultaValoresPage())),
        ),
        CardGridModel(
          title: 'Consulta Valores\nde Falecidos',
          icon: Symbols.deceased,
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () =>
                  push(context, const ConsultaValoresFalecidoPage())),
        ),
        CardGridModel(
          title: 'Serviços do Banco Central',
          icon: Symbols.account_balance,
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () =>
                  push(context, const ConsultaValoresFalecidoPage())),
        ),
        CardGridModel(
          title: 'Estatísticas\ndo SVR',
          icon: Symbols.monitoring,
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const EstatisticasHomePage())),
        )
      ];

  List<AppCardModel> get itens1 => [
        AppCardModel(
          icon: Icons.contact_support_outlined,
          title: 'O que é o SVR?',
          subtitle:
              'Saiba o que é e como funciona o Sistema de Valores a Receber',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const OqueEPage())),
        ),
        AppCardModel(
          icon: Icons.psychology_alt_outlined,
          title: 'O que é conta GOV.BR',
          subtitle: 'Saiba como aumentar o nível de sua conta GOV.BR',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const AumentarNivelPage())),
        ),
      ];
  List<AppCardModel> get itens2 => [
        AppCardModel(
          icon: Icons.paid_outlined,
          title: 'Tenho valores a receber?',
          subtitle: 'Saiba se você tem e quanto tem em dinheiro esquecido.',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const ComoSaberPage())),
        ),
        AppCardModel(
          icon: Icons.price_change_outlined,
          title: 'Como receber o dinheiro esquecido?',
          subtitle: 'Entenda o processo.',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const ComoReceberPage())),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      onWillPop: () async => push(context, const HomeExitBanner()),
      active: AdController.adConfig.banner.active,
      behavior: ['${widget.name}1', '${widget.name}2'],
      child: body(context),
    );
  }

  Widget body(_) {
    return AppListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset('assets/images/logo.png')),
              const W(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getGreeting(),
                      style: AppTheme.text.extra.xl2(const Color(0xFF1B1C1C)),
                    ),
                    const H(4),
                    Text(
                      'Bem vindo ao Valores a Receber\nGuia 2023',
                      style: AppTheme.text.normal.sm(const Color(0xFF777777)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const Divisor(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardValor(
                title: EstatisticasValores.estatisticasValores.home!.title!,
                value: EstatisticasValores.estatisticasValores.home!.value!,
                desc: EstatisticasValores.estatisticasValores.home!.desc!,
                onClick: () => AdController.showInterstitialTransitionAd(
                    context,
                    onComplete: () => push(context, const ComoReceberHomePage())),
              ),
              const H(16),
              Row(
                children: [
                  Expanded(child: AppCardGrid(gridItens[0])),
                  const W(8),
                  Expanded(child: AppCardGrid(gridItens[1])),
                ],
              ),
              const H(16),
              AppBannerAd(AdBannerStorage.get('${widget.name}1')),
              const H(16),
              Row(
                children: [
                  Expanded(child: AppCardGrid(gridItens[2])),
                  const W(8),
                  Expanded(child: AppCardGrid(gridItens[3])),
                ],
              ),
              const H(32),
              const H(32),
              const LabelDoubleColumn('Conteúdos', 'Valores a Receber'),
              const H(16),
              AppCardList(itens1),
              const H(16),
              AppBannerAd(AdBannerStorage.get('${widget.name}2')),
              const H(16),
              AppCardList(itens2),
            ],
          ),
        )
      ],
    );
  }

  String getGreeting() {
    DateTime now = DateTime.now();
    int currentHour = now.hour;

    if (currentHour >= 6 && currentHour < 12) {
      return 'Bom dia';
    } else if (currentHour >= 12 && currentHour < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }
}
