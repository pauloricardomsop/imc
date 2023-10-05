import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/como_receber_quiz/como_receber_quiz_controller.dart';
import 'package:svr/app/modules/como_receber_quiz/como_receber_quiz_model.dart';
import 'package:svr/app/modules/como_receber_quiz/ui/como_receber_quiz_02.dart';

class ComoReceberQuiz01HomePage extends AdStatefulWidget {
  ComoReceberQuiz01HomePage({Key? key})
      : super(key: key, name: 'ComoReceberQuiz01HomePage');

  @override
  State<ComoReceberQuiz01HomePage> createState() =>
      _ComoReceberQuiz01HomePageState();
}

class _ComoReceberQuiz01HomePageState extends State<ComoReceberQuiz01HomePage> {
  final ComoReceberQuizController _controller = ComoReceberQuizController();

  List<QuizOptionModel> quizOptions = [
    QuizOptionModel('SIM'),
    QuizOptionModel('NÃO'),
  ];

  @override
  void initState() {
    _controller.dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: AppColors.surfaceContainerLowest,
      bottom: Footer(
        AppButton(
          label: 'PRÓXIMO',
          icon: Symbols.trending_flat,
          onTap: () {
            var controller = _controller.quizStream.value;
            if(controller.question01 == null) {
              NotificationService.negative('Selecione uma das opções');
              return;
            }
            AdManager.showIntersticial(context, flow: AdFlow.going, onDispose: () => push(context, ComoReceberQuiz02Page()));
          },
        ),
      ),
      child: StreamOut<ComoReceberQuizModel>(
        stream: _controller.quizStream.listen,
        child: (_, model) => AppListView(
          children: [
            const Header.light(),
            const AppTitle('Está com CPF e Data de\nNascimento das pessoas que\nvocê quer verificar?', color: AppColors.onSurface),
            const H(16),
            const AppDesc('No sistema de Valores a Receber você pode receber para você ou para falecidos de sua família.', color: AppColors.onSurface),
            const H(16),
            QuizOptionWidget(
              options: quizOptions,
              option: model.question01,
              onChanged: (e) {
                model.question01 = e;
                _controller.quizStream.update();
              },
            ),
          ],
        ),
      ),
    );
  }
}
