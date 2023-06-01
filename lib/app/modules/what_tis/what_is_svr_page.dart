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
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/modules/what_is/what_is/what_is_it_for_svr_page.dart';
// import 'package:svr/app/modules/what_is/what_is/what_is_know_receive_page.dart';
// import 'package:svr/app/modules/what_is/what_is/what_is_news_page.dart';

class WhatIsSvrPage extends JourneyStatefulWidget {
  const WhatIsSvrPage({Key? key}) : super(key: key, name: 'WhatIsSvrPage');

  @override
  State<WhatIsSvrPage> createState() => WhatIsSvrPageState();
}

class WhatIsSvrPageState extends State<WhatIsSvrPage> {
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
          title: 'Para que serve o SVR?',
          subtitle: 'Entenda para que serve o SVR e tire suas dúvidas.',
          onTap: () {
            Navigator.pop(context);
            push(context, const WhatIsItForSvrPage());
          },
        ),
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
              push(context, const WhatIsItForSvrPage());
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
                    'O Sistema de Valores a Receber (SVR) é um serviço do Banco Central no qual você pode consultar se você, sua empresa ou pessoa falecida tem dinheiro esquecido em algum banco, consórcio ou outra instituição e, caso tenha, saber como solicitar o valor.',
              ),
              const H(16),
              const HeaderHero(
                desc:
                    'O Sistema de Valores a Receber (SVR) é um serviço do Banco Central no qual você pode consultar se você, sua empresa ou pessoa falecida tem dinheiro esquecido em algum banco, consórcio ou outra instituição e, caso tenha, saber como solicitar o valor.',
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/documentos-necessarios.jpg',
              ),
              const H(16),
              CheckList(checkList),
              const H(16),
              AppBannerAd(AdBannerStorage.get('${widget.name}2')),
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
