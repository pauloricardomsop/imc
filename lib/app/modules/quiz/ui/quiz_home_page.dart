import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/ui/quiz_renda_familiar_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class QuizHomePage extends AdStatefulWidget {
  QuizHomePage({Key? key}) : super(key: key, name: 'QuizHomePage');

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(
        AppButton(
          label: 'RESPONDER QUIZ',
          onTap: () => push(context, QuizRendaFamiliarPage()),
          icon: Symbols.trending_flat,
        ),
      ),
      child: body(context),
    );
  }

  Widget body(_) {
    return const AppListView(
      children: [
        Header.light(),
        HeaderTextLight(
          'Quem tem direito ao Novo Bolsa Família?',
          'Este QUIZ tem o propósito de tirar as dúvidas sobre quem tem ou não direito de participar do programa. \n\nMas fique atento, o resultado deste QUIZ são baseados nas regras do programa, e não é um resultado definitivo. Para ter certeza se tem ou não direito de participar do programa, dirija-se até o CRAS mais próximo de sua casa.',
        ),
      ],
    );
  }
}
