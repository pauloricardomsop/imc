import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/quiz_controller.dart';
import 'package:svr/app/modules/quiz/quiz_model.dart';
import 'package:svr/app/modules/quiz/topics/quiz_vacinas_disponibilizzadas_page.dart';
import 'package:svr/app/modules/quiz/ui/quiz_matriculados_4a18_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class QuizCartaoVacinaFilhos0a6Page extends AdStatefulWidget {
  QuizCartaoVacinaFilhos0a6Page({Key? key})
      : super(key: key, name: 'QuizCartaoVacinaFilhos0a6Page');

  @override
  State<QuizCartaoVacinaFilhos0a6Page> createState() =>
      _QuizCartaoVacinaFilhos0a6PageState();
}

class _QuizCartaoVacinaFilhos0a6PageState
    extends State<QuizCartaoVacinaFilhos0a6Page> {
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
          onTap: () {
            var controller = _controller.quizStream.value;
            if (controller.possuiCartaoVacinaFilhos0a6 == null) {
              NotificationService.negative('Selecione uma das opções');
              return;
            }
            push(context, QuizMatriculados4a18Page());
          },
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
            action: AppIcon.info(
                onTap: () => push(context, QuizVacinasDisponibilizadasPage())),
          ),
        ),
        const AppTitle(
            'Seus filhos de até 6 anos estão com o cartão de vacinação em dia?'),
        const H(16),
        QuizOptionWidget(
          options: quizOptions,
          option: model.possuiCartaoVacinaFilhos0a6,
          onChanged: (e) {
            model.possuiCartaoVacinaFilhos0a6 = e;
            _controller.quizStream.update();
          },
        ),
        const H(24),
        const BannerWidget(),
      ],
    );
  }
}
