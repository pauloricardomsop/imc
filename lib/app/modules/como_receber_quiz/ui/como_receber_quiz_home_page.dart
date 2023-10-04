import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/como_receber_quiz/ui/como_receber_quiz_01.dart';

class ComoReceberQuizHomePage extends AdStatefulWidget {
  ComoReceberQuizHomePage({Key? key})
      : super(key: key, name: 'ComoReceberQuizHomePage');

  @override
  State<ComoReceberQuizHomePage> createState() =>
      _ComoReceberQuizHomePageState();
}

class _ComoReceberQuizHomePageState extends State<ComoReceberQuizHomePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(
        AppButton(
          label: 'VERIFICAR VALORES',
          icon: Symbols.trending_flat,
          onTap: () => push(context, ComoReceberQuiz01HomePage()),
        ),
      ),
      child: const AppListView(
        children: [
          Header.light(),
          HeaderTitle('Questionário para\nverificar como\nreceber dinheiro\nesquecido.', color: AppColors.onSurface),
          H(16),
          HeaderDesc('Veja o que você precisa para verificar se você possui dinheiro esquecido nos bancos e saiba como receber esse dinheiro pelo sistema do Banco Central.', color: AppColors.onSurface),
        ],
      ),
    );
  }
}
