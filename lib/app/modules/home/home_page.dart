import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:share_plus/share_plus.dart';
import 'package:svr/app/core/components/exit_banner.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/como_receber_quiz/ui/como_receber_quiz_home_page.dart';
import 'package:svr/app/modules/consulta_svr/ui/consultar_svr_home_page.dart';
import 'package:svr/app/modules/home/topics/como_aumentar_nivel_page.dart';
import 'package:svr/app/modules/home/topics/como_receber_meus_valores_page.dart';
import 'package:svr/app/modules/home/topics/como_receber_se_tenho_valores_page.dart';
import 'package:svr/app/modules/home/topics/o_que_e_page.dart';
import 'package:svr/app/modules/servicos_banco_central/servico_banco_central_home_page.dart';

class HomePage extends AdStatefulWidget {
  HomePage({Key? key}) : super(key: key, name: 'HomePage');

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CardFeature> get cardFeatureHeaderItens => [
        CardFeature.hasBlur(
          label: 'Consultar Valores\na Receber',
          prefix: Symbols.payments,
          onTap: () => push(context, ConsultaValoresHomePage()),
        ),
        CardFeature.hasBlur(
          label: 'Saiba se seu\nCPF está ativo',
          prefix: Symbols.assured_workload,
          onTap: () => push(context, Container()),
        ),
      ];

  List<CardFeature> get cardFeatureItens => [
        CardFeature(
          label: 'Consultar Valores\na Receber',
          prefix: Symbols.payments,
          onTap: () => push(context, ConsultaValoresHomePage()),
        ),
        CardFeature(
          label: 'Consultar Valores\nde Falecidos',
          prefix: Symbols.deceased,
          onTap: () => push(context, Container()),
        ),
        CardFeature(
          label: 'Saiba se seu CPF\nestá ativo',
          prefix: Symbols.assured_workload,
          onTap: () => push(context, Container()),
        ),
        CardFeature(
          label: 'Serviços do Banco\nCentral',
          prefix: Symbols.monitoring,
          onTap: () => push(context, ServicoBancoCentralHomePage()),
        ),
        CardFeature(
          label: 'Estatísticas\ndo SVR',
          prefix: Symbols.add_chart,
          onTap: () => push(context, Container()),
        ),
        CardFeature(
          label: 'Últimas Notícias\ndo SVR',
          prefix: Symbols.newsmode,
          onTap: () => push(context, Container()),
        ),
      ];

  List<CardFeature> get cardFeatureFullItens => [
        CardFeature.full(
          label: 'O que é o Sistema de\nValores a Receber?',
          prefix: Symbols.counter_1,
          sufix: const AppIcon.frontLight(),
          onTap: () => push(context, ComoReceberMeusValoresPage()),
        ),
        CardFeature.full(
          label: 'O que é conta GOV.BR\ne como subir de nível?',
          prefix: Symbols.counter_2,
          sufix: const AppIcon.frontLight(),
          onTap: () => push(context, ComoReceberSeTenhoValoresPage()),
        ),
        CardFeature.full(
          label: 'Como saber se tenho\nvalores a receber?',
          prefix: Symbols.counter_3,
          sufix: const AppIcon.frontLight(),
          onTap: () => push(context, ComoAumentarNivelPage()),
        ),
        CardFeature.full(
          label: 'Como receber o\ndinheiro esquecido?',
          prefix: Symbols.counter_4,
          sufix: const AppIcon.frontLight(),
          onTap: () => push(context, OQueEPage()),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        statusBarColor: AppColors.surfaceContainer,
        onWillPop: () async {
          push(context, ExitBanner());
          return false;
        },
        child: AppListView(
          children: [
            Header(
              top: HeaderTop(
                leading: const AppTitle('Bem vindo ao app\nValores a Receber'),
                action: AppIcon.share(
                    onTap: () async => await Share.share(
                        'https://play.google.com/store/apps/details?id=com.ldcapps.svr')),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( 'Mais de 37 milhões de Brasileiros com dinheiro esquecido nos bancos.', style: const TextStyle(color: AppColors.onSurfaceVariant).bodyLarge),
                  const H(24),
                  AppButton(label: 'VER COMO RECEBER', icon: Symbols.east, onTap: () => AdManager.showIntersticial(context, onDispose: () => push(context, ComoReceberQuizHomePage()))),
                  const H(24),
                  const AppTitle('Mais acessados'),
                  const H(24),
                  CardFeatures(cardFeatureHeaderItens)
                ],
              ),
            ),
            const AppTitle('Veja mais opções'),
            const H(24),
            CardFeatures(cardFeatureItens),
            const H(24),
            const AppTitle('Mais conteúdo'),
            const H(20),
            const BannerWidget(),
            const H(20),
            CardFeatures.full(cardFeatureFullItens),
          ],
        ));
  }
}
