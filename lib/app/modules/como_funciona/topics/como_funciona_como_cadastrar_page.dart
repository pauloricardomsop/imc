import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/ui/quiz_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ComoFuncionaComoCadastrarPage extends AdStatefulWidget {
  ComoFuncionaComoCadastrarPage({Key? key})
      : super(key: key, name: 'ComoFuncionaComoCadastrarPage');

  @override
  State<ComoFuncionaComoCadastrarPage> createState() =>
      _ComoFuncionaComoCadastrarPageState();
}

class _ComoFuncionaComoCadastrarPageState
    extends State<ComoFuncionaComoCadastrarPage> {
  List<CheckListModel> get checklistDocumentos => [
        CheckListModel(
          label: 'Certidão de nascimento',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'Comprovante de residência',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'Certidão de casamento caso seja \ncasado(a)',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'CPF',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'RG',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'Carteira de Trabalho',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'Título de Eleitor',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label:
              'Registro Administrativo de Nascimento Indígena (RANI). No caso se a pessoa for indígena.',
          icon: Symbols.check_circle,
        ),
      ];

  List<CheckListModel> get checklistRegras => [
        CheckListModel(
          label: 'Famílias em situação de extrema pobreza;',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'Famílias em situação de pobreza;',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'Famílias em regra de emancipação.',
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
          title: 'Como se cadastrar no Novo Bolsa Família?',
          desc:
              'Para se cadastrar no Novo Bolsa Família você deve procurar um CRAS e se dirigir até a unidade de atendimento com os documentos listados abaixo.',
        ),
        const BannerWidget(),
        const AppTitle('Documentos necessários'),
        CheckList(checklistDocumentos),
        const H(24),
        const AppTitle('Lembre-se das regras de \nenquadramento'),
        const H(24),
        const AppDesc(
            'Fique atento nas regras de enquadramento do Bolsa Família. Somente podem participar do programa pessoas que estejam nas seguintes situações:'),
        const H(24),
        CheckList(checklistRegras)
      ],
    );
  }
}
