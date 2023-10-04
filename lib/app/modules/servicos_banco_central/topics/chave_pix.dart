import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class ChavePixPage extends AdStatefulWidget {
  ChavePixPage({Key? key}) : super(key: key, name: 'ChavePixPage');

  @override
  State<ChavePixPage> createState() => _ChavePixPageState();
}

class _ChavePixPageState extends State<ChavePixPage> {
  List<CheckListModel> get checkList => [
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Consultar detalhes de suas chaves Pix cadastradas; e',
    ),
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Conferir se existe dívida que não contratou;',
    ),
  ];

  List<CardAccordeonModel> get accordeonList => [
    CardAccordeonModel(
      title: 'Como consultar o Relatório',
      desc: const AppDesc('Consulte seu Relatório de Chaves Pix no sistema Registrato, usando sua Conta Gov.br (nível prata ou ouro).'),
    ),
    CardAccordeonModel(
      title: 'Como corrigir informações do relatório',
      desc: const AppDesc('Caso seja identificado algum erro ou seus dados estejam desatualizados, você deve solicitar a retificação junto à instituição (financeira ou participante) na qual a chave foi registrada. \n\nSe o problema não for resolvido, reclame em www.consumidor.gov.br ou pelo Fale Conosco do Banco Central.'),
    ),
    CardAccordeonModel(
      title: 'Prazo de atualização do relatório',
      desc: const AppDesc('A atualização do relatório acontece em tempo real. Ou seja, assim que a chave Pix é registrada na instituição, o sistema do Banco Central é informado e o dado é incluído no relatório.'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(
        AppButton(
          label: 'ACESSAR REGISTRATO',
          icon: Symbols.open_in_new,
          onTap: () => push(context, const Text('ACESSAR REGISTRATO')),
        ),
      ),
      child: AppListView(
        children: [
          const Header.text(
            'Chaves PIX',
            'O Relatório de Chaves Pix mostra as chaves Pix que você cadastrou, vinculadas aos dados de sua conta (nome do banco, número da agência e da conta).',
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
