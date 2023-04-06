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
import 'package:benefits_brazil/app/core/theme/app_theme.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:flutter/material.dart';

class BfHowWorkReceivePage extends JourneyStatefulWidget {
  const BfHowWorkReceivePage({super.key}) : super(name: 'BfHowWorkReceivePage');

  @override
  State<BfHowWorkReceivePage> createState() => _BfHowWorkReceivePage();
}

class _BfHowWorkReceivePage extends State<BfHowWorkReceivePage> {
  final List<CheckListModel> _checkListItens = [
    CheckListModel(
      icon: Icons.done,
      label:
          'Agências da CAIXA, postos de atendimento bancários ou postos avançados de atendimento;',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Unidades lotéricas;',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Correspondentes CAIXA aqui;',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Terminais de autoatendimento;',
    ),
    CheckListModel(
      icon: Icons.done,
      label: 'Unidades itinerantes.',
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
        const BackHeaderBenefit(benefit: Benefit.bf),
        const H(32),
        const HeaderHero(
          image: 'https://ldcapps.com/wp-content/uploads/2023/03/baixa-renda.jpeg',
          title: 'Como receber seus benefícios do Bolsa Família?',
          desc:
              'Um cartão é emitido para o responsável pela família poder sacar, todo mês, seu benefício.',
        ),
        const H(32),
        AppBannerAd(AdBannerStorage.get(widget.name)),
        const H(32),
        const SectionHeaderSm('Conta Poupança Social Digital.',
            'Sempre que o cadastro estiver com informações completas e o dado correto do CPF do responsável pela família, automaticamente é aberta a Conta Poupança Social Digital. Além de poder sacar o benefício com o cartão, nesta conta o beneficiário pode fazer transferências, pagar contas e fazer PIX diretamente pelo aplicativo. Caso os dados não estejam suficientes, é aberta uma conta simples para pagamento do benefício.'),
        const H(8),
        const AppCardPurple(
            'Todos os meses, o benefício é disponibilizado, conforme data estabelecida pelo calendário do programa, sendo pago sempre nos últimos 10 dias úteis do mês, de acordo com o último dígito do Número de Identificação Social (NIS) do responsável.'),
        const H(24),
        const SectionHeaderSm('Quem já era beneficiário do Auxílio Brasil.',
            'Quem já é beneficiário pode continuar sacando os benefícios com o cartão que já possui atualmente. Os novos beneficiários receberão cartões no endereço informado durante a inscrição no Cadastro Único.'),
        const SectionHeaderSm(
            'A família precisa ter conta bancária ou abrir por conta própria para receber o Bolsa Família?',
            'Não. Sempre que o cadastro estiver com informações completas e o dado correto do CPF do Responsável pela Família, automaticamente é aberta a Conta Poupança Social Digital e nela são depositadas as parcelas mensais dos benefícios. A Conta Poupança Social Digital não tem custo e nem tarifa de manutenção.'),
        const H(8),
        const AppCardPurple(
            'Caso não seja possível abrir uma conta bancária, uma conta social é aberta e os valores disponibilizados à família.'),
        const H(24),
        Text(
          'A família pode sacar o benefício do Bolsa Família nos seguintes canais de pagamentos:',
          style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
        ),
        const H(16),
        CheckList(_checkListItens),
        const H(16),
      ],
    );
  }
}
