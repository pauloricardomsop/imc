import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_carroussel.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/header_hero.dart';
import 'package:benefits_brazil/app/core/components/in_footer_cta.dart';
import 'package:benefits_brazil/app/core/components/section_header_sm.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:benefits_brazil/app/core/models/carroussel_model.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:flutter/material.dart';

class BfHowRegisterHasReceivePage extends JourneyStatefulWidget {
  const BfHowRegisterHasReceivePage({super.key}) : super(name: 'BfHowRegisterHasReceivePage');

  @override
  State<BfHowRegisterHasReceivePage> createState() => _BfHowRegisterHasReceivePage();
}

class _BfHowRegisterHasReceivePage extends State<BfHowRegisterHasReceivePage> {
  final List<CarrousselModel> _carrousselItens = [
    CarrousselModel(
      title: 'Poupança social digital',
      desc:
          'A Conta Poupança Social Digital é uma poupança simplificada aberta automaticamente em nome dos responsáveis pela família, sem necessidade de solicitação ou comparecimento a uma agência da CAIXA.\n\nA conta pode ser acessada pelo aplicativo CAIXA Tem para realizar compras com o cartão de débito virtual, pagamento de boletos, contas de água, luz e telefone, fazer transferências, saques sem cartão nos caixas eletrônicos e nas lotéricas.',
    ),
    CarrousselModel(
      title: 'Poupança CAIXA Fácil',
      desc:
          'A Poupança CAIXA Fácil é uma conta simplificada, com limite de saldo e movimentação mensal de R\$ 3.000,00. A conta possui um cartão magnético que possibilita compras, depósitos, saldos, transferências e muito mais.',
    ),
    CarrousselModel(
        title: 'Saque com cartão Bolsa Família',
        desc:
            'Com o cartão é possível realizar o saque nos terminais de autoatendimento da CAIXA, nos correspondentes CAIXA Aqui e nas unidades Lotéricas.\n\nPara realizar o saque nos correspondentes CAIXA Aqui e nas unidades Lotéricas, é necessário apresentar um documento de identificação e o cartão do benefício.\n\n',
        alert:
            'O cartão é enviado para o endereço informado no Cadastro Único quando da inclusão da família no Programa.'),
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
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackHeaderBenefit(benefit: Benefit.bf),
              const H(32),
              HeaderHero(
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/como-receber-o-bolsa-familia.jpg',
                title: 'Como receber seu dinheiro no Bolsa Família?',
                desc: 'Veja as melhores formas de receber seu benefício Bolsa Família em 2023!',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              const SectionHeaderSm('Entenda como funciona.',
                  'O pagamento do Bolsa Família é realizado mensalmente pela CAIXA, conforme calendário de pagamentos.\n\nO pagamento pode ser realizado das seguintes formas:'),
            ],
          ),
        ),
        AppCarroussel(_carrousselItens),
        const H(16),
        InFooterCta(
          onTap: () => execUrl('https://www.google.com/maps/search/CRAS/'),
          icon: Icons.near_me_outlined,
          label: 'Encontrar um CRAS',
        )
      ],
    );
  }
}
