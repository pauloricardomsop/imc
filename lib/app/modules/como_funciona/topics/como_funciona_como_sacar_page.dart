import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/ui/quiz_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ComoFuncionaComoSacarPage extends AdStatefulWidget {
  ComoFuncionaComoSacarPage({Key? key})
      : super(key: key, name: 'ComoFuncionaComoSacarPage');

  @override
  State<ComoFuncionaComoSacarPage> createState() =>
      _ComoFuncionaComoSacarPageState();
}

class _ComoFuncionaComoSacarPageState extends State<ComoFuncionaComoSacarPage> {
  List<CheckListModel> get checklistConta => [
        CheckListModel(
          label: 'Poupança social digital;',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'Conta corrente de depósito à vista;',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'Conta especial de depósito à vista;',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'Conta contábil (plataforma social do programa);',
          icon: Symbols.check_circle,
        ),
      ];
  List<CheckListModel> get checklistAgencia => [
        CheckListModel(
          label: 'Agências Caixa Econômica Federal 1',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'Lotéricas CAIXA',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'CAIXA Aqui',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'Banco 24h',
          icon: Symbols.check_circle,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bottom: Footer(
          AppButton(
            onTap: () => AdManager.showIntersticial(context,
                onDispose: () => push(context, QuizHomePage())),
            label: 'VEJA SE VOCÊ TEM DIREITO',
            icon: Symbols.trending_flat,
          ),
        ),
        child: body(context));
  }

  Widget body(_) {
    return AppListView(
      children: [
        const Header(
          top: HeaderTop(),
          title: 'Como sacar o benefício recebido?',
          desc:
              'Listamos as formas possíveis de receber seu benefício, confira.',
        ),
        const BannerWidget(),
        const AppTitle('Abrindo uma conta'),
        const H(16),
        const AppDesc(
            'A abertura da Conta Poupança Social digital para os pagamentos do Bolsa Família, poderá ocorrer de forma automática, em nome do Responsável Familiar inscrito no Cadastro Único.'),
        const H(24),
        CheckList(checklistConta),
        const H(24),
        const AppTitle('Como sacar o benefício?'),
        const H(16),
        const AppDesc(
            'Você poderá sacar seu benefício em algum local credenciado pela conta de pagamentos autorizada pelo programa.'),
        const H(24),
        CheckList(checklistAgencia),
        const H(24),
        const AppDesc(
            'Você poderá sacar seu benefício em algum local credenciado pela conta de pagamentos autorizada pelo programa.')
      ],
    );
  }
}
