import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_card_purple.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/check_list.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/header_hero.dart';
import 'package:benefits_brazil/app/core/components/section_header_sm.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:benefits_brazil/app/core/models/check_list_model.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:flutter/material.dart';

class ValeGasHowWorkReceivePage extends JourneyStatefulWidget {
  const ValeGasHowWorkReceivePage({super.key}) : super(name: 'Vale111111GasHowWorkReceivePage');

  @override
  State<ValeGasHowWorkReceivePage> createState() => _BfHowWorkReceivePage();
}

class _BfHowWorkReceivePage extends State<ValeGasHowWorkReceivePage> {
  final List<CheckListModel> _checkListItens = [
    CheckListModel(
      icon: Icons.done,
      label: 'Conta Poupança Social Digital;',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Conta Poupança Caixa Fácil;',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Plataforma social, sendo possível o saque com cartão social.',
    ),
  ];

  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.get(widget.name),
        body: body(context),
      ),
    );
  }

  Widget body(_) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const BackHeaderBenefit(benefit: Benefit.valeGas),
        const H(32),
        const HeaderHero(
          image: 'https://ldcapps.com/wp-content/uploads/2023/03/images.jpeg',
          title: 'Como receber seus benefícios do Vale Gás?',
          desc:
              'O pagamento do auxílio gás é depositado a cada dois meses, utilizando o mesmo calendário de pagamentos do Vale Gás.',
        ),
        const H(32),
        AppBannerAd(AdBannerStorage.get(widget.name)),
        const H(32),
        const SectionHeaderSm(
            'O benefício é pago também de forma similar ao Auxílio Brasil, nas opções:', empty),
        CheckList(_checkListItens),
        const H(8),
        const AppCardPurple(
            'Caso você tenha direito ao benefício com base nas informações que mencionamos, procure uma unidade do CRAS e faça o registro familiar para solicitá-lo.'),
        const H(16),
      ],
    );
  }
}
