import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/home/topics/como_receber_se_tenho_valores_page.dart';

class EmprestimosFinanciamentosPage extends AdStatefulWidget {
  EmprestimosFinanciamentosPage({Key? key}) : super(key: key, name: 'EmprestimosFinanciamentosPage');

  @override
  State<EmprestimosFinanciamentosPage> createState() => _EmprestimosFinanciamentosPageState();
}

class _EmprestimosFinanciamentosPageState extends State<EmprestimosFinanciamentosPage> {
  List<CheckListModel> get checkList => [
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Avaliar se está muito endividado e se deve ou não contratar mais uma operação de crédito;',
    ),
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Conferir se existe dívida que não contratou;',
    ),
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Conhecer melhor suas dívidas, para tentar renegociar ou transferir para outro banco.',
    ),
  ];

  List<CardAccordeonModel> get accordeonList => [
    CardAccordeonModel(
      title: 'Como consultar o relatório',
      desc: const AppDesc('Consulte seu Relatório de Empréstimos e Financiamentos (SCR) no sistema Registrato, usando sua Conta Gov.br (nível prata ou ouro).'),
    ),
    CardAccordeonModel(
      title: 'Prazo de atualização do relatório',
      desc: const AppDesc('O Relatório de Empréstimos e Financiamentos (SCR) não é atualizado imediatamente após o pagamento da dívida. \n\nOs dados são enviados pelos bancos uma única vez por mês. É possível ver que a dívida foi paga quando você consultar o relatório no mês seguinte ao pagamento, por volta do dia 20. Mas, o sistema não limpa o histórico e a dívida continua aparecendo nas datas em que ficou atrasada. \n\nSe precisar comprovar o pagamento antes de o relatório ser atualizado, peça o comprovante de quitação ao banco.'),
    ),
    CardAccordeonModel(
      title: 'Tipos de dívidas que aparecem no relatório',
      children: [
        const Column(
          children: [
             AppDesc('O Relatório de Empréstimos e Financiamentos (SCR) apresenta as seguintes dívidas, em dia ou em atraso, com bancos e financeiras:'),
             H(16),
             PointsCheckList('empréstimos e financiamentos;'),
             PointsCheckList('adiantamentos;'),
             PointsCheckList('operações de arrendamento mercantil (leasing);'),
             PointsCheckList('operações com cartão de crédito que envolvam empréstimo ou financiamento, como saque em caixa eletrônico, pagamento menor que o total da fatura e pagamento parcelado na loja;'),
             PointsCheckList('coobrigações e garantias prestadas; e'),
             PointsCheckList('outras operações com risco de crédito.'),
             H(16),
             AppDesc('O relatório ainda pode informar limites pré-aprovados pela instituição, mas que você ainda não utilizou, como cheque especial, cartão de crédito, capital de giro e conta garantida; ou saldo de crédito a liberar (principalmente no caso de liberação de crédito em fases, no caso de projetos). Essas informações só aparecem se você também tiver dívidas em dia ou em atraso, em valor igual ou superior a\nR\$ 200,00.'),
          ],
        ),
      ]
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(
        AppButton(
          label: 'ACESSAR REGISTRATO',
          icon: Symbols.open_in_new,
          onTap: () async => execUrl('https://registrato.bcb.gov.br/registrato/'),
        ),
      ),
      child: AppListView(
        children: [
          const Header.text(
            'Empréstimos e Financiamentos',
            'O Relatório de Empréstimos e Financiamentos (SCR) mostra todas as suas dívidas com bancos e financeiras. Você pode verificar o saldo devedor e o tipo de operação de crédito, se a dívida está em dia ou em atraso, e outras informações.',
          ),
          const AppTitle('Para que serve?'),
          const H(24),
          const AppDesc('O relatório serve para você:'),
          const H(24),
          CheckList(checkList),
          const H(24),
          const AppTitle('Perguntas Frequentes'),
          const H(24),
          const AppDesc('Confira perguntas frequentemente feitas por usuários, e tire suas dúvidas.'),
          const H(24),
          CardAppAccordeon(accordeonList),
          const H(24),
          const AppDesc('Preparamos um QUIZ para saber se você tem ou não direito de participar do Novo Bolsa Família. Para participar, toque no botão fixo na parte inferior desta página.')
        ],
      ),
    );
  }
}
