import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_accordeon.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/button_icon.dart';
import 'package:svr/app/core/components/card_sm.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/label_double_column.dart';
import 'package:svr/app/core/models/carroussel_model.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class WhatIsPage extends JourneyStatefulWidget {
  const WhatIsPage({Key? key}) : super(key: key, name: 'WhatIsPage');

  @override
  State<WhatIsPage> createState() => WhatIsPageState();
}

class WhatIsPageState extends State<WhatIsPage> {
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
          title: 'O que é o SVR?',
          subtitle: 'Aprenda de uma vez por todas o que é o SRV.',
          onTap: () {},
          // onTap: () => push(context, const WhatIsSvrPage()),
        ),
        CardSm(
          title: 'Para que serve o SVR?',
          subtitle: 'Entenda para que serve o SVR e tire suas dúvidas.',
          onTap: () {},
          // onTap: () => push(context, const WhatIsItForSvrPage()),
        ),
        CardSm(
          title: 'Quais as novidades do SVR para 2023?',
          subtitle: 'Fique por dentro do que hà de novo no SVR.',
          onTap: () {},
          // onTap: () => push(context, const WhatIsNewsPage()),
        ),
        CardSm(
          title: 'Como sei se tenho valores a receber?',
          subtitle: 'Aprenda como o sistema funciona e saiba se tem valores pra receber.',
          onTap: () {},
          // onTap: () => push(context, WhatIsKnowReceivePage()),
        ),
      ];

  final List<AccordeonModel> _questions = [
    AccordeonModel(
      title: 'Qual o prazo para receber o dinheiro esquecido?',
      desc:
          'O prazo para receber depende da forma de solicitação. Se for solicitado no sistema com chave PIX o valor será recebido em até 12 dias úteis. Se for solicitado diretamente em contato com a instituição, ou pelo sistema sem PIX, o prazo pode passar de 12 dias úteis.',
    ),
    AccordeonModel(
      title: 'Quais são as formas de receber o dinheiro esquecido?',
      desc:
          'O dinheiro esquecido pode ser solicitado pelo SRV ou direto com a instituição financeira ou banco, e pode ser enviado ao cliente por PIX, TED ou DOC.',
    ),
    AccordeonModel(
      title: 'Como saber se tenho valores a receber do Banco Central?',
      desc:
          'Basta entrar no site Valores a Receber, do Banco Central, inserir o número do seu CPF, data de nascimento e conferir se tem direito.',
    ),
    AccordeonModel(
      title: 'Quais as recomendações para evitar golpes no SVR?',
      desc:
          'O Banco Central recomenda que as pessoas desconfiem de toda informação recebida por WhatsApp e não acessem nenhum link nas mensagens, pois podem roubar senhas, instalar vírus e programas maliciosos. A única fonte oficial de informações sobre o SVR é o site oficial do Banco Central.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      active: AdController.adConfig.banner.active,
      behavior: ['${widget.name}1', '${widget.name}2'],
      body: body(context),
    );
  }

  Widget body(_) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const BackHeader(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderHero(
                title: 'Saiba em definitivo, o que é o SVR.',
                desc:
                    'O Sistema de Valores a Receber (SVR) mostra se você tem algum dinheiro a receber em bancos e em outras instituições.',
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/documentos-necessarios.jpg',
              ),
              const H(24),
              ButtonIcon(
                onTap: () {},
                invert: true,
                icon: Icons.navigate_next,
                label: 'Ver passo a passo',
              ),
              const H(24),
              AppBannerAd(AdBannerStorage.get('${widget.name}1')),
              const H(16),
              ...itens,
              const H(24),
              const LabelDoubleColumn('Perguntas', 'Frequentes'),
            ],
          ),
        ),
        AppAccordeon(_questions),
        const H(24),
        AppBannerAd(AdBannerStorage.get('${widget.name}2')),
        const H(16),
      ],
    );
  }
}
