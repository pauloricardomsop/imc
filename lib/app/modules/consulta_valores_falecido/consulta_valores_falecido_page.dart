import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/card_sm.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_valores_falecido/topics/accesar_sistema_page.dart';
import 'package:svr/app/modules/consulta_valores_falecido/topics/acessar_consulta_page.dart';
import 'package:svr/app/modules/consulta_valores_falecido/topics/conferir_valores_page.dart';
import 'package:svr/app/modules/consulta_valores_falecido/topics/documentos_page.dart';
import 'package:svr/app/modules/consulta_valores_falecido/topics/termos_responsabilidade_page.dart';

class ConsultaValoresFalecidoPage extends JourneyStatefulWidget {
  const ConsultaValoresFalecidoPage({Key? key})
      : super(key: key, name: 'ConsultaValoresFalecidoPage');

  @override
  State<ConsultaValoresFalecidoPage> createState() => ConsultaValoresFalecidoPageState();
}

class ConsultaValoresFalecidoPageState extends State<ConsultaValoresFalecidoPage> {
  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    super.initState();
  }

  List<CardSm> get itens => [
        CardSm(
          title: 'Acessar a consulta do SVR',
          subtitle:
              'Consulte valores de falecidos com CPF e data de nascimento da pessoa falecida.',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const AcessarConsultaPage())),
        ),
        CardSm(
          title: 'Acessar sistema do SVR',
          subtitle: 'Acesse o sistema SVR através de uma conta GOV.BR.',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const AccesarSistemaPage())),
        ),
        CardSm(
          title: 'Concorde com os termos de responsabilidade.',
          subtitle: 'Só é possível resgatar o dinheiro, aceitando os termos de responsabilidade.',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const TermosResponsabilidadePage())),
        ),
        CardSm(
          title: 'Confira os valores a receber.',
          subtitle: 'Veja as faixas de valores a receber por cada instituição financeira.',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const ConferirValoresPage())),
        ),
        CardSm(
          title: 'Documentos para resgatar junto as instituições.',
          subtitle:
              'Veja quais documentos são necessários e entenda o processo para resgatar dinheiro de falecidos.',
          onTap: () => AdController.showInterstitialTransitionAd(context,
              onComplete: () => push(context, const DocumentosPage())),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        active: AdController.adConfig.banner.active, behavior: [widget.name], child: body(context));
  }

  Widget body(_) {
    return AppListView(
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
                title: 'Consulta de Valores a Receber de Falecidos.',
                desc:
                    'Veja o passo a passo de como consultar e como resgatar valores a receber de falecidos.\n\nImportante ressaltar que você deve ser herdeiro, inventariante, testamentário ou representante legal.',
              ),
              const H(24),
              Text(
                'Passo a passo de como resgatar valores de pessoas falecidas?',
                style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
              ),
              ...itens
            ],
          ),
        ),
      ],
    );
  }
}
