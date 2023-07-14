import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_accordeon.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/check_list.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/components/redirect_banner.dart';
import 'package:svr/app/core/models/accordeon_model.dart';
import 'package:svr/app/core/models/check_list_model.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class RegistratoContasRelacionamentoPage extends JourneyStatefulWidget {
  const RegistratoContasRelacionamentoPage({Key? key})
      : super(key: key, name: 'RegistratoContasRelacionamentoPage');

  @override
  State<RegistratoContasRelacionamentoPage> createState() =>
      RegistratoContasRelacionamentoPageState();
}

class RegistratoContasRelacionamentoPageState
    extends State<RegistratoContasRelacionamentoPage> {
  List<CheckListModel> get _checklistcontas => [
        CheckListModel(
            icon: Icons.done,
            label:
                'Em quais bancos e instituições você tem ou teve conta, investimento ou outro relacionamento; e'),
        CheckListModel(
            icon: Icons.done,
            label:
                'A data de início e, se for o caso, a data de fim do relacionamento.'),
      ];
  List<CheckListModel> get _checklistpraqueserve => [
        CheckListModel(
            icon: Icons.done,
            label:
                'Conferir em quais bancos possui conta, investimentos e outro tipo de relacionamento;'),
        CheckListModel(
            icon: Icons.done,
            label:
                'Verificar se seu CPF ou CNPJ foi usado indevidamente para abertura de conta;'),
        CheckListModel(
            icon: Icons.done,
            label:
                'Pesquisar contas e relacionamentos bancários de pessoa falecida para inventário.'),
      ];

  List<AccordeonModel> get _accordeonlist => [
        AccordeonModel(
            title: 'Como provar que você não possui conta em bancos',
            desc:
                'A Certidão Negativa de Relacionamento com o Sistema Financeiro informa que você não possui conta aberta ou investimento em bancos. \n\nMas se você tem alguma conta ou investimento, mesmo que esteja sem movimentar há anos, não conseguirá emitir essa certidão. \n\nNesse caso, você deve consultar o Relatório de Contas e Relacionamentos em Bancos, no sistema Registrato.'),
        AccordeonModel(
            title: 'Relacionamento com banco que você não conhece',
            desc:
                'Se as informações estão erradas ou se seus dados foram usados sem sua autorização por terceiros para abertura de conta, entre em contato com o banco. \n\nPode acontecer de o seu banco não ser registrado na base de dados do Banco Central (BC), mas fazer parte de um grupo econômico ou ter vínculo com alguma instituição registrada, que fica responsável por encaminhar dados ao BC. Estamos trabalhando para diferenciar esses vínculos nos relatórios.'),
        AccordeonModel(
            title:
                'Tipos de instituições obrigadas a registrar as informações no relatório',
            desc:
                'As seguintes instituições enviam dados ao Banco Central (BC): \n• bancos, \n• cooperativas de crédito, \n• instituições de pagamento autorizadas pelo BC na condição de emissoras de moeda eletrônica (contas de pagamento) \n• corretoras e distribuidoras de títulos e valores mobiliários, \n• financeiras (sociedades de crédito, financiamento e investimento), e \n• Sociedade de Crédito Direto (SCD) e Sociedade de Empréstimo entre Pessoas (SEP), desde que sejam emissoras de moeda eletrônica (contas de pagamento). \n\nO relatório não informa dados de relacionamento com: \n• administradoras de consórcio, \n• instituição de pagamento emissoras de moeda eletrônica (contas de pagamento), quando não sejam autorizadas pelo Banco Central, mesmo quando façam Pix, \n• instituições de pagamento que atuam exclusivamente como credenciadoras ou iniciadoras de pagamento, e \n• instituições fiscalizadas por Susep e Previc.'),
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
    return AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: [widget.name],
        bottom: infooter(),
        child: body(context));
  }

  Widget body(_) {
    return Stack(
      children: [
        AppListView(
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
                    title: 'Contas e Relacionamentos',
                    desc:
                        'O Relatório de Contas e Relacionamentos em Bancos (CCS) mostra:',
                  ),
                  const H(16),
                  CheckList(_checklistcontas),
                  Text(
                    'Ele não mostra números de agências e de contas, dados cadastrais, nem saldos e movimentações. \n\nO relatório contém informações dos relacionamentos iniciados a partir 01/01/2001 ou em data anterior, desde que não encerrados até 31/12/2000.',
                    style: AppTheme.text.normal.base(const Color(0xFF474747)),
                  ),
                  const H(16),
                  const HeaderHero(
                    title: 'Para que serve?',
                    desc: 'O relatório serve para você:',
                  ),
                  const H(16),
                  CheckList(_checklistpraqueserve),
                  const H(16),
                  const HeaderHero(
                    title: 'Perguntas Frequentes',
                    desc:
                        'Confira perguntas frequentemente feitas por usuários, e tire suas dúvidas.',
                  ),
                ],
              ),
            ),
            AppAccordeon(_accordeonlist),
            const H(30),
          ],
        ),
      ],
    );
  }

  Widget infooter() {
    return InFooterCta(
      onTap: () => push(
          context,
          RedirectPage(
            'Você será encaminhado para um site oficial do Banco Central.',
            'https://registrato.bcb.gov.br/registrato/',
            titleInfooter: 'IR PARA REGISTRATO',
            child: Column(children: [
              Text('Você será redirecionado para o site oficial do GOV.BR:',
                  style: AppTheme.text.normal.xs(const Color(0xFF474747))),
              Text('registrato.bcb.gov.br',
                  style: AppTheme.text.extra.xs(const Color(0xFF474747)))
            ]),
          )),
      label: 'ACESSAR O REGISTRATO',
      icon: Icons.arrow_forward_rounded,
      invert: true,
    );
  }
}
