import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/home/topics/como_receber_se_tenho_valores_page.dart';

class ContasRelacionamentosPage extends AdStatefulWidget {
  ContasRelacionamentosPage({Key? key}) : super(key: key, name: 'ContasRelacionamentosPage');

  @override
  State<ContasRelacionamentosPage> createState() => _ContasRelacionamentosPageState();
}

class _ContasRelacionamentosPageState extends State<ContasRelacionamentosPage> {
  List<CheckListModel> get checkList => [
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Em quais bancos e instituições você tem ou teve conta, investimento ou outro relacionamento; e',
    ),
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'A data de início e, se for o caso, a data de fim do relacionamento.',
    ),
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Conferir em quais bancos possui conta, investimentos e outro tipo de relacionamento;',
    ),
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Verificar se seu CPF ou CNPJ foi usado indevidamente para abertura de conta;',
    ),
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Pesquisar contas e relacionamentos bancários de pessoa falecida para inventário.',
    ),
  ];

  List<CardAccordeonModel> get accordeonList => [
    CardAccordeonModel(
      title: 'Como provar que você não possui conta em bancos',
      desc: const AppDesc('A Certidão Negativa de Relacionamento com o Sistema Financeiro informa que você não possui conta aberta ou investimento em bancos. \n\nMas se você tem alguma conta ou investimento, mesmo que esteja sem movimentar há anos, não conseguirá emitir essa certidão. \n\nNesse caso, você deve consultar o Relatório de Contas e Relacionamentos em Bancos, no sistema Registrato.'),
    ),
    CardAccordeonModel(
      title: 'Relacionamento com banco que você não conhece',
      desc: const AppDesc('Se as informações estão erradas ou se seus dados foram usados sem sua autorização por terceiros para abertura de conta, entre em contato com o banco. \n\nPode acontecer de o seu banco não ser registrado na base de dados do Banco Central (BC), mas fazer parte de um grupo econômico ou ter vínculo com alguma instituição registrada, que fica responsável por encaminhar dados ao BC. Estamos trabalhando para diferenciar esses vínculos nos relatórios.'),
    ),
    CardAccordeonModel(
      title: 'Tipos de instituições obrigadas a registrar as informações no relatório',
      children: [
        const Column(
          children: [
             AppDesc('As seguintes instituições enviam dados ao Banco Central (BC):'),
             H(16),
             PointsCheckList('bancos,'),
             PointsCheckList('cooperativas de crédito,'),
             PointsCheckList('instituições de pagamento autorizadas pelo BC na condição de emissoras de moeda eletrônica (contas de pagamento)'),
             PointsCheckList('corretoras e distribuidoras de títulos e valores mobiliários,'),
             PointsCheckList('financeiras (sociedades de crédito, financiamento e investimento), e'),
             PointsCheckList('Sociedade de Crédito Direto (SCD) e Sociedade de Empréstimo entre Pessoas (SEP), desde que sejam emissoras de moeda eletrônica (contas de pagamento).'),
             H(16),
             AppDesc('O relatório não informa dados de relacionamento com:'),
             PointsCheckList('administradoras de consórcio,'),
             PointsCheckList('instituição de pagamento emissoras de moeda eletrônica (contas de pagamento), quando não sejam autorizadas pelo Banco Central, mesmo quando façam Pix,'),
             PointsCheckList('instituições de pagamento que atuam exclusivamente como credenciadoras ou iniciadoras de pagamento, e'),
             PointsCheckList('instituições fiscalizadas por Susep e Previc.'),
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
            'Contas e Relacionamentos',
            'O Relatório de Contas e Relacionamentos em Bancos (CCS) mostra:',
          ),
          CheckList(checkList.sublist(0, 2)),
          const H(24),
          const AppDesc('Ele não mostra números de agências e de contas, dados cadastrais, nem saldos e movimentações. \n\nO relatório contém informações dos relacionamentos iniciados a partir 01/01/2001 ou em data anterior, desde que não encerrados até 31/12/2000.'),
          const H(24),
          const AppTitle('Para que serve?'),
          const H(24),
          const AppDesc('O relatório serve para você:'),
          const H(24),
          CheckList(checkList.sublist(2, 5)),
          const H(24),
          const AppTitle('Perguntas Frequentes'),
          const H(24),
          const AppDesc('Confira perguntas frequentemente feitas por usuários, e tire suas dúvidas.'),
          const H(24),
          CardAppAccordeon(accordeonList),
        ],
      ),
    );
  }
}
