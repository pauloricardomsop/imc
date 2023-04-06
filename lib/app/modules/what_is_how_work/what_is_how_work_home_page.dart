import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_carroussel.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/button_icon.dart';
import 'package:svr/app/core/components/card_sm.dart';
import 'package:svr/app/core/components/check_list.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/label_double_column.dart';
import 'package:svr/app/core/models/carroussel_model.dart';
import 'package:svr/app/core/models/check_list_model.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/what_is_how_work/what_is/what_is_home_page.dart';

class WhatIsHowWorkHomePage extends JourneyStatefulWidget {
  const WhatIsHowWorkHomePage({Key? key}) : super(key: key, name: 'WhatIsHowWorkHomePage');

  @override
  State<WhatIsHowWorkHomePage> createState() => WhatIsHowWorkHomePageState();
}

class WhatIsHowWorkHomePageState extends State<WhatIsHowWorkHomePage> {
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
          title: 'O que é o Sistema Valores a Receber',
          subtitle: 'Saiba o que é e como funciona.',
          onTap: () => push(context, const WhatIsHomePage()),
        ),
        CardSm(
          title: 'Como acessar meus valores?',
          subtitle: 'Saiba acessar o sistema para recuperar seu dinheiro.',
          onTap: () => push(context, Container()),
        ),
        CardSm(
          title: 'Como acesso valores de falecidos?',
          subtitle: 'Aprenda como acessar o sistema para receber dinheiro de falecidos.',
          onTap: () => push(context, Container()),
        ),
      ];

  List<CheckListModel> checkList = [
    CheckListModel(
        icon: Icons.done, label: 'Contas corrente ou poupança encerradas com saldo disponível;'),
    CheckListModel(
        icon: Icons.done,
        label:
            'Cotas de capital e rateio de sobras líquidas de ex-participantes de cooperativas de crédito;'),
    CheckListModel(
        icon: Icons.done, label: 'Recursos não procurados de grupos de consórcio encerrados;'),
    CheckListModel(icon: Icons.done, label: 'Tarifas cobradas indevidamente;'),
    CheckListModel(
        icon: Icons.done,
        label: 'Parcelas ou despesas de operações de crédito cobradas indevidamente;'),
    CheckListModel(
        icon: Icons.done,
        label: 'Parcelas ou despesas de operações de crédito cobradas indevidamente;'),
    CheckListModel(
        icon: Icons.done,
        label: 'Contas de pagamento pré ou pós-paga encerradas com saldo disponível;'),
    CheckListModel(
        icon: Icons.done,
        label:
            'Contas de registro mantidas por corretoras e distribuidoras encerradas com saldo disponível;'),
    CheckListModel(
        icon: Icons.done, label: 'Outros recursos disponíveis nas instituições para devolução.'),
  ];

  final List<CarrousselModel> _questions = [
    CarrousselModel(
      title: 'Qual o prazo para receber o dinheiro esquecido?',
      desc:
          'O prazo para receber depende da forma de solicitação. Se for solicitado no sistema com chave PIX o valor será recebido em até 12 dias úteis. Se for solicitado diretamente em contato com a instituição, ou pelo sistema sem PIX, o prazo pode passar de 12 dias úteis.',
    ),
    CarrousselModel(
      title: 'Quais são as formas de receber o dinheiro esquecido?',
      desc:
          'O dinheiro esquecido pode ser solicitado pelo SRV ou direto com a instituição financeira ou banco, e pode ser enviado ao cliente por PIX, TED ou DOC.',
    ),
    CarrousselModel(
      title: 'Como saber se tenho valores a receber do Banco Central?',
      desc:
          'Basta entrar no site Valores a Receber, do Banco Central, inserir o número do seu CPF, data de nascimento e conferir se tem direito.',
    ),
    CarrousselModel(
      title: 'Quais as recomendações para evitar golpes no SVR?',
      desc:
          'O Banco Central recomenda que as pessoas desconfiem de toda informação recebida por WhatsApp e não acessem nenhum link nas mensagens, pois podem roubar senhas, instalar vírus e programas maliciosos. A única fonte oficial de informações sobre o SVR é o site oficial do Banco Central.',
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
        const BackHeader(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderHero(
                title: 'O que é e como funciona o Sistema de Valores a Receber ou SVR.',
                desc:
                    'Descubra o que é, como funcione e como acessar seus valores e até mesmo de pessoas falecidas.,',
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/documentos-necessarios.jpg',
              ),
              const H(24),
              ButtonIcon(
                onTap: () {},
                icon: Icons.navigate_next,
                invert: true,
                label: 'Consultar Valores',
              ),
              const H(24),
              AppBannerAd(AdBannerStorage.get('${widget.name}1')),
              const H(16),
              ...itens,
              const H(24),
              Text(
                'Caso tenha direito, o sistema também permite solicitar o valor. As quantias são referentes a:',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
              const H(24),
              CheckList(checkList),
              AppBannerAd(AdBannerStorage.get('${widget.name}2')),
              const H(24),
              const LabelDoubleColumn('Perguntas', 'Frequentes'),
            ],
          ),
        ),
        AppCarroussel(_questions),
        const H(16),
      ],
    );
  }
}
