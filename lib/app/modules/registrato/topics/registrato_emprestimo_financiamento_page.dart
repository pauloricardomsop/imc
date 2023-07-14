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

class RegistratoEmprestimoFinanciamentoPage extends JourneyStatefulWidget {
  const RegistratoEmprestimoFinanciamentoPage({Key? key})
      : super(key: key, name: 'RegistratoEmprestimoFinanciamentoPage');

  @override
  State<RegistratoEmprestimoFinanciamentoPage> createState() =>
      RegistratoEmprestimoFinanciamentoPageState();
}

class RegistratoEmprestimoFinanciamentoPageState
    extends State<RegistratoEmprestimoFinanciamentoPage> {
  List<CheckListModel> get _checklist => [
        CheckListModel(
            icon: Icons.done,
            label: 'Avaliar se está muito endividado e se deve ou não contratar mais uma operação de crédito;'),
        CheckListModel(
            icon: Icons.done,
            label: 'Conferir se existe dívida que não contratou;'),
        CheckListModel(
            icon: Icons.done,
            label: 'Conhecer melhor suas dívidas, para tentar renegociar ou transferir para outro banco.'),
      ];
  List<AccordeonModel> get _accordeonlist => [
        AccordeonModel(
            title: 'Como consultar o relatório',
            desc:
                'Consulte seu Relatório de Empréstimos e Financiamentos (SCR) no sistema Registrato, usando sua Conta Gov.br (nível prata ou ouro).'),
        AccordeonModel(
            title: 'Prazo de atualização do relatório',
            desc:  'O Relatório de Empréstimos e Financiamentos (SCR) não é atualizado imediatamente após o pagamento da dívida.  \n\nOs dados são enviados pelos bancos uma única vez por mês. É possível ver que a dívida foi paga quando você consultar o relatório no mês seguinte ao pagamento, por volta do dia 20. Mas, o sistema não limpa o histórico e a dívida continua aparecendo nas datas em que ficou atrasada. \n\nSe precisar comprovar o pagamento antes de o relatório ser atualizado, peça o comprovante de quitação ao banco.'),
        AccordeonModel(
            title: 'Tipos de dívidas que aparecem no relatório',
            desc:  'O Relatório de Empréstimos e Financiamentos (SCR) apresenta as seguintes dívidas, em dia ou em atraso, com bancos e financeiras: \n\n• empréstimos e financiamentos; \n• adiantamentos; \n• operações de arrendamento mercantil (leasing); \n• operações com cartão de crédito que envolvam empréstimo ou financiamento, como saque em caixa eletrônico, pagamento menor que o total da fatura e pagamento parcelado na loja; \n• coobrigações e garantias prestadas; e \n• outras operações com risco de crédito. \n\nO relatório ainda pode informar limites pré-aprovados pela instituição, mas que você ainda não utilizou, como cheque especial, cartão de crédito, capital de giro e conta garantida; ou saldo de crédito a liberar (principalmente no caso de liberação de crédito em fases, no caso de projetos). Essas informações só aparecem se você também tiver dívidas em dia ou em atraso, em valor igual ou superior a R\$ 200,00.'),
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
                    title: 'Empréstimos e Financiamentos',
                    desc:  'O Relatório de Empréstimos e Financiamentos (SCR) mostra todas as suas dívidas com bancos e financeiras. Você pode verificar o saldo devedor e o tipo de operação de crédito, se a dívida está em dia ou em atraso, e outras informações.',
                  ),
                  const H(16),
                  const HeaderHero(
                    title: 'Para que serve?',
                    desc:  'O relatório serve para você:',
                  ),
                  const H(16),
                  CheckList(_checklist),
                  const H(16),
                  const HeaderHero(
                    title: 'Perguntas Frequentes',
                    desc:  'Confira perguntas frequentemente feitas por usuários, e tire suas dúvidas.',
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
              Text('Você será redirecionado para o site oficial do GOV.BR:', style: AppTheme.text.normal.xs(const Color(0xFF474747))),
              Text('registrato.bcb.gov.br', style: AppTheme.text.extra.xs(const Color(0xFF474747)))
            ]),
          )),
      label: 'ACESSAR O REGISTRATO',
      icon: Icons.arrow_forward_rounded,
      invert: true,
    );
  }
}
