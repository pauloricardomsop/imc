import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_card_purple.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/header_hero.dart';
import 'package:benefits_brazil/app/core/components/in_footer_cta.dart';
import 'package:benefits_brazil/app/core/components/section_header_sm.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:benefits_brazil/app/core/models/carroussel_model.dart';
import 'package:benefits_brazil/app/core/theme/app_theme.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:flutter/material.dart';

class ValeGasHowRegisterHasApprovedPage extends JourneyStatefulWidget {
  const ValeGasHowRegisterHasApprovedPage({super.key})
      : super(name: 'ValeGasHowRegisterHasApprovedPage');

  @override
  State<ValeGasHowRegisterHasApprovedPage> createState() => _ValeGasHowRegisterHasApprovedPage();
}

class _ValeGasHowRegisterHasApprovedPage extends State<ValeGasHowRegisterHasApprovedPage> {
  final List<CarrousselModel> _carrousselItens = [
    CarrousselModel(
      title: 'Consulte seu benefício pelo app Cadastro Único.',
      desc:
          'Para saber se o cadastro foi aprovado após a entrega de documentos e entrevista social, o Responsável da Família  pode fazer a consulta no site CadÚnico ou pelo aplicativo Cadastro Único.',
    ),
    CarrousselModel(
      title: 'Correspondência da Caixa Econômica Federal.',
      desc:
          'Quando seu benefício for concedido, a CAIXA enviará correspondência para a residência comunicando a seleção para o Programa, de acordo com o endereço informado no Cadastro Único.',
    ),
    CarrousselModel(
      title: 'Consulte seu benefício através do atendimento CAIXA.',
      desc:
          'Também é possível consultar a situação do benefício via Atendimento CAIXA pelo telefone 111, e pelo aplicativo CAIXA Tem.',
    ),
    CarrousselModel(
      title: 'Central de Relacionamento Bolsa Família.',
      desc:
          'Também é possível fazer a consulta ligando para a Central de Relacionamento do Auxílio Brasil, no número 121, de segunda a sexta-feira, das 7h às 19h. A ligação é gratuita.',
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
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackHeaderBenefit(benefit: Benefit.valeGas),
              const H(32),
              HeaderHero(
                image: 'https://ldcapps.com/wp-content/uploads/2023/03/como-saber-se-fui-aprovado.jpg',
                title: 'Como saber se fui aprovado no Vale Gás?',
                desc: 'Veja como saber se foi aprovado no Vale Gás.',
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              const SectionHeaderSm('Saiba se você foi aprovado pelo aplicativo Bolsa Família.',
                  'Veja o passo a passo para consultar pelo aplicativo Bolsa Família'),
              const AppCardPurple('''
1. Abra o aplicativo Auxílio Brasil e clique em “Acessar”;\n
2. Clique na opção “Quero entrar com minha senha do app Auxílio Brasil ou desejo me cadastrar”.\n
3. Digite seu CPF, marque a opção “Não sou um robô” e avance;\n
4. Digite sua senha e confirme;\n
5. Leia as informações que aparecem na tela;\n
6. Clique em “Benefícios” para ver quais estão disponíveis e a situação deste;\n
7. Clicando em “Ver parcelas” é possível ter acesso ao status dos pagamentos passados ou futuros.\n
'''),
              const H(32),
              const SectionHeaderSm('Saiba se você foi aprovado pelo aplicativo CAIXA Tem.',
                  'Veja o passo a passo para consultar pelo aplicativo CAIXA Tem'),
              const AppCardPurple('''
1. Abra o aplicativo Caixa Tem;\n
2. Faça login com CPF e senha cadastrada;\n
3. Marque a opção “Não sou um robô” e clique em “Continuar”;\n
4. Clique na opção “Extrato” e procure pela sigla AUX GÁS para verificar o recebimento do benefício, que ocorre conforme calendário de pagamentos.\n
''')
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Text(
            'Pronto, após verificar sua situação está aprovada, veja como fazer para receber seu benefício.',
            style: AppTheme.text.normal.base(const Color(0xFF474747)),
          ),
        ),
        InFooterCta(
          onTap: () => execUrl('https://www.google.com/maps/search/CRAS/'),
          icon: Icons.near_me_outlined,
          label: 'Encontrar um CRAS',
        )
      ],
    );
  }
}
