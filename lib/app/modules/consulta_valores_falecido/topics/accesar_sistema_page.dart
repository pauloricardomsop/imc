import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/ad_icon.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_image.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/check_list.dart';
import 'package:svr/app/core/components/exit_banner.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/components/web_view_page.dart';
import 'package:svr/app/core/models/check_list_model.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class AccesarSistemaPage extends JourneyStatefulWidget {
  const AccesarSistemaPage({Key? key}) : super(key: key, name: 'AccesarSistemaPage');

  @override
  State<AccesarSistemaPage> createState() => AccesarSistemaPageState();
}

class AccesarSistemaPageState extends State<AccesarSistemaPage> {
  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    super.initState();
  }

  List<CheckListModel> get checkList => [
        CheckListModel(
            icon: Icons.arrow_forward,
            label:
                'Caso haja valores, vai constar a informação "O CPF pesquisado tem valores a receber". E será preciso clicar em "Acessar o SVR" na parte inferior da página;',
            image: const AppImage(
              url:
                  'https://ldcapps.com/wp-content/uploads/2023/04/Como-acessar-o-sistema-do-SVR-1.png',
              height: 200,
            )),
        CheckListModel(
            icon: Icons.arrow_forward,
            label:
                'Na sequência, será preciso se logar na conta gov.br - é preciso ter nível de acesso ouro ou prata (veja como obter). No gov.br devem ser informados o CPF e a senha - cadastrada no sistema - do herdeiro, inventariante, testamentário ou representante legal. Não coloque os dados do falecido;',
            image: const AppImage(
              url:
                  'https://ldcapps.com/wp-content/uploads/2023/04/Como-acessar-o-sistema-do-SVR-2.png',
              height: 200,
            )),
        CheckListModel(
            icon: Icons.arrow_forward,
            label:
                'Na próxima janela, o sistema vai dar duas opções: "Meus valores a receber" e "Valores para pessoas falecidas". Vá na segunda opção e clique em "Acessar";',
            image: const AppImage(
              url:
                  'https://ldcapps.com/wp-content/uploads/2023/04/Como-acessar-o-sistema-do-SVR-3.png',
              height: 200,
            )),
        CheckListModel(
            icon: Icons.arrow_forward,
            label:
                'Agora será preciso informar novamente o CPF e a data de nascimento do falecido. Na sequência, clique em "Consultar";',
            image: const AppImage(
              url:
                  'https://ldcapps.com/wp-content/uploads/2023/04/Como-acessar-o-sistema-do-SVR-4.png',
              height: 200,
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: ['${widget.name}1', '${widget.name}2'],
        bottom: _inFooterCta(),
        child: body(context));
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
                title: 'Como acessar o sistema do SVR',
                desc:
                    'Se a pessoa falecida possuir alguma valor a receber, você poderá acessar o sistema do SVR. Veja abaixo o passo a passo de como entrar no sistema.',
              ),
              const H(16),
              CheckList(checkList),
              const H(16),
            ],
          ),
        ),
      ],
    );
  }

  InFooterCta _inFooterCta() {
    return InFooterCta(
      onTap: () => push(
          context,
          ExitBanner(
            widget.name,
            title: 'Consulta de valores a receber do BACEN',
            buttonLabel: 'CONSULTAR VALORES',
            buttonSubLabel: 'Após o anúncio você terá acesso ao formulário de valores a receber:  ',
            buttonSubLabelBold: 'https://valoresareceber.bcb.gov.br/publico',
            onClick: () => AdController.showInterstitialTransitionAd(context,
          onComplete: () =>
              push(context, const WebViewPage('https://valoresareceber.bcb.gov.br/publico'))),
          )),

      label: 'CONSULTAR VALORES',
      invert: true,
      icon: const AdIcon(),
    );
  }
}
