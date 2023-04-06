import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/button_icon.dart';
import 'package:svr/app/core/components/card_sm.dart';
import 'package:svr/app/core/components/check_list.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/models/check_list_model.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class WhatIsKnowReceivePage extends JourneyStatefulWidget {
  const WhatIsKnowReceivePage({Key? key}) : super(key: key, name: 'WhatIsKnowReceivePage');

  @override
  State<WhatIsKnowReceivePage> createState() => WhatIsKnowReceivePageState();
}

class WhatIsKnowReceivePageState extends State<WhatIsKnowReceivePage> {
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
          title: 'Como aumentar o nível da minha Conta .GOV',
          subtitle: 'Aprenda como o sistema funciona e saiba se tem valores pra receber.',
          onTap: () {
            Navigator.pop(context);
            push(context, Container());
          },
        ),
      ];

  List<CheckListModel> checkList = [
    CheckListModel(
      icon: Icons.arrow_forward,
      label: 'Acesse o site do Sistema de Valores a Receber;',
    ),
    CheckListModel(
      icon: Icons.arrow_forward,
      label: 'Vá em “Entrar com Gov.br”;',
    ),
    CheckListModel(
      icon: Icons.arrow_forward,
      label:
          'Faça o login com seu CPF e senha no Gov.br. Caso ainda não tenha uma conta, basta fazer seu cadastro;',
    ),
    CheckListModel(
      icon: Icons.arrow_forward,
      label: 'Conceda as autorizações necessárias;',
    ),
    CheckListModel(
      icon: Icons.arrow_forward,
      label: 'Informe se a pesquisa será feita por CPF ou CNPJ e insira os dados solicitados;',
    ),
    CheckListModel(
      icon: Icons.arrow_forward,
      label: 'Clique em “Consultar”;',
    ),
    CheckListModel(
      icon: Icons.arrow_forward,
      label: 'Siga os passos indicados na tela.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: ['${widget.name}1', '${widget.name}2'],
        body: body(context),
      ),
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
              push(context, Container());
            },
            icon: Icons.open_in_new,
            label: 'Consultar Agora',
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
                title: 'Como sei se tenho valores a receber?',
                desc:
                    'Para consultar seus valores a receber, é preciso fazer login no site valoresareceber.bcb.gov.br com os dados de acesso do Gov.br, desde que seja nível prata ou ouro de segurança. Para acessar sua conta, siga o passo a passo:',
              ),
              const H(16),
              const HeaderHero(
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/documentos-necessarios.jpg',
              ),
              const H(24),
              ButtonIcon(
                onTap: () {},
                invert: true,
                icon: Icons.open_in_new,
                label: 'Cosultar Valores',
              ),
              const H(24),
              CheckList(checkList),
              Text(
                'Lembrando que para fazer esse passo a passo, é preciso ter o nível de segurança prata ou ouro no Gov.br. Se o nível de segurança da sua conta for o bronze, eleve o nível com uma das opções oferecidas, com o reconhecimento facial, por exemplo.',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
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
