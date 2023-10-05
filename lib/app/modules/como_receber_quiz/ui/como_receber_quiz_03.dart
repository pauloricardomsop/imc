import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/como_receber_quiz/como_receber_quiz_controller.dart';
import 'package:svr/app/modules/como_receber_quiz/como_receber_quiz_model.dart';
import 'package:svr/app/modules/como_receber_quiz/ui/como_receber_quiz_result_sucess.dart';

class ComoReceberQuiz03Page extends AdStatefulWidget {
  ComoReceberQuiz03Page({Key? key})
      : super(key: key, name: 'ComoReceberQuiz03Page');

  @override
  State<ComoReceberQuiz03Page> createState() =>
      _ComoReceberQuiz03PageState();
}

class _ComoReceberQuiz03PageState extends State<ComoReceberQuiz03Page> {
  final ComoReceberQuizController _controller = ComoReceberQuizController();

  List<QuizOptionModel> quizOptions = [
    QuizOptionModel('SIM'),
    QuizOptionModel('NÃO'),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: AppColors.surfaceContainerLowest,
      bottom: Footer(
        AppButton(
          label: 'VER RESULTADO',
          icon: const AdIcon(),
          onTap: () {
            var controller = _controller.quizStream.value;
            if(controller.question03 == null) {
              NotificationService.negative('Selecione uma das opções');
              return;
            }
            AdManager.showRewarded(onDispose: () => push(context, ComoReceberQuizResultSuccessPage()));
          },
        ),
      ),
      child: StreamOut<ComoReceberQuizModel>(
        stream: _controller.quizStream.listen,
        child: (_, model) => AppListView(
          children: [
            const Header.light(),
            const AppTitle('Você possui uma chave PIX\ncadastrada?', color: AppColors.onSurface),
            const H(16),
            const AppDesc('Somente é possível solicitar o resgate do valor através de uma chave PIX.', color: AppColors.onSurface),
            const H(16),
            QuizOptionWidget(
              options: quizOptions,
              option: model.question03,
              onChanged: (e) {
                model.question03 = e;
                _controller.quizStream.update();
              },
            ),
          ],
        ),
      ),
    );
  }
}
