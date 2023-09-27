import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/ui/quiz_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ComoFuncionaOQueEPage extends AdStatefulWidget {
  ComoFuncionaOQueEPage({Key? key})
      : super(key: key, name: 'ComoFuncionaOQueEPage');

  @override
  State<ComoFuncionaOQueEPage> createState() => _ComoFuncionaOQueEPageState();
}

class _ComoFuncionaOQueEPageState extends State<ComoFuncionaOQueEPage> {
  List<CheckListModel> get checklist => [
        CheckListModel(
          label:
              'O Bolsa Família integra em apenas um programa várias políticas públicas de assistência social, saúde, educação, emprego e renda.',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label:
              'O novo programa social de transferência direta e indireta de renda é destinado às famílias em situação de pobreza e de extrema pobreza em todo o país.',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label:
              'Além de garantir uma renda básica a essas famílias, o programa busca simplificar a cesta de benefícios e estimular a emancipação dessas famílias para que alcancem autonomia e superem situações de vulnerabilidade social.',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label:
              'O Bolsa Família é coordenado pelo Ministério da Cidadania, responsável por gerenciar os benefícios do programa e o envio de recursos para pagamento.',
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
          title: 'O que é o programa Novo Bolsa Família?',
          desc:
              'O Novo Bolsa Família é um programa assistencial que todo mês distribui \nrenda para várias famílias brasileiras.',
        ),
        const BannerWidget(),
        CheckList(checklist),
        const H(24),
        const AppTitle('Participe!'),
        const H(24),
        const AppDesc(
            'Preparamos um QUIZ para saber se você tem ou não direito de participar do Novo Bolsa Família. Para participar, toque no botão fixo na parte inferior desta página.')
      ],
    );
  }
}
