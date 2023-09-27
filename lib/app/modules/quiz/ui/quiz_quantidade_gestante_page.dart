import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/quiz_controller.dart';
import 'package:svr/app/modules/quiz/quiz_model.dart';
import 'package:svr/app/modules/quiz/ui/quiz_gestantes_prenatal_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class QuizQuantidadeGestantesPage extends AdStatefulWidget {
  QuizQuantidadeGestantesPage({Key? key})
      : super(key: key, name: 'QuizQuantidadeGestantesPage');

  @override
  State<QuizQuantidadeGestantesPage> createState() =>
      _QuizQuantidadeGestantesPageState();
}

class _QuizQuantidadeGestantesPageState
    extends State<QuizQuantidadeGestantesPage> {
  final QuizController _controller = QuizController();

  List<QuizOptionModel> quizOptions = [
    QuizOptionModel('SIM'),
    QuizOptionModel('NÃO'),
  ];
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(
        AppButton(
          label: 'PRÓXIMO',
          onTap: () => push(context, QuizGestantesPreNatalPage()),
          icon: Symbols.trending_flat,
        ),
      ),
      child: StreamOut<QuizModel>(
        stream: _controller.quizStream.listen,
        child: (_, model) => body(context, model),
      ),
    );
  }

  Widget body(_, QuizModel model) {
    return AppListView(
      children: [
        Header.light(
          top: HeaderTop(
            backgroundColor: AppColors.white,
            leading: const AppIcon.back(
                backgroundColor: AppColors.surfaceContainer,
                iconColor: AppColors.onSurface),
            action: AppIcon.logout(onTap: () => pops(context, 8)),
          ),
        ),
        const AppTitle('Quantas gestantes moram em sua residência?'),
        const H(16),
        AppFieldCounter(
          onChanged: (e) {
            model.quantidadeGestantes = e;
            _controller.quizStream.update();
          },
        ),
      ],
    );
  }
}
