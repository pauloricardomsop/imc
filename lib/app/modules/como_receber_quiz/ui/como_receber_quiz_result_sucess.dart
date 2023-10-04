import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/modules/como_receber_quiz/como_receber_quiz_controller.dart';
import 'package:svr/app/modules/como_receber_quiz/como_receber_quiz_model.dart';

class ComoReceberQuizResultSuccessPage extends AdStatefulWidget {
  ComoReceberQuizResultSuccessPage({Key? key})
      : super(key: key, name: 'ComoReceberQuizResultSuccessPage');

  @override
  State<ComoReceberQuizResultSuccessPage> createState() =>
      _ComoReceberQuizResultSuccessPageState();
}

class _ComoReceberQuizResultSuccessPageState
    extends State<ComoReceberQuizResultSuccessPage> {
  final ComoReceberQuizController _controller = ComoReceberQuizController();

  List<CheckListModel> get checkList => [
        CheckListModel(
          icon: _controller.quizStream.value.response01
              ? Symbols.check_circle
              : Symbols.warning,
          label: 'CPF e Data de Nascimento',
          color: _controller.quizStream.value.response01
              ? AppColors.success
              : AppColors.error,
        ),
        CheckListModel(
          icon: _controller.quizStream.value.response02
              ? Symbols.check_circle
              : Symbols.warning,
          label: 'Conta GOV.BR Nível Ouro',
          color: _controller.quizStream.value.response02
              ? AppColors.success
              : AppColors.error,
        ),
        CheckListModel(
          icon: _controller.quizStream.value.response03
              ? Symbols.check_circle
              : Symbols.warning,
          label: 'Chave PIX Cadastrada.',
          color: _controller.quizStream.value.response03
              ? AppColors.success
              : AppColors.error,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(
        AppButton(
          label: _controller.labelButtom,
          icon: Symbols.trending_flat,
          onTap: () => _controller.redirectPage(context),
        ),
      ),
      child: StreamOut<ComoReceberQuizModel>(
        stream: _controller.quizStream.listen,
        child: (_, model) => AppListView(
          children: [
            Center(child: AppDesc(_controller.title)),
            const H(18),
            const BannerWidget(),
            const H(20),
            AppImage(url: _controller.image, fit: BoxFit.contain, isSVG: true),
            const H(24),
            AppTitle(_controller.titlePage, textAlign: TextAlign.center),
            const H(8),
            Center(child: AppDesc(_controller.descPage, textAlign: TextAlign.center)),
            const H(24),
            const Divisor(),
            const H(24),
            CheckList(checkList),
          ],
        ),
      ),
    );
  }
}
