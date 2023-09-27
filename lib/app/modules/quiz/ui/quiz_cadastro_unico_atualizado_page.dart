import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/quiz_controller.dart';
import 'package:svr/app/modules/quiz/quiz_model.dart';
import 'package:svr/app/modules/quiz/topics/quiz_como_saber_cadunico_page.dart';
import 'package:svr/app/modules/quiz/ui/quiz_result_second_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class QuizCadastroUnicoAtualizadoPage extends AdStatefulWidget {
  QuizCadastroUnicoAtualizadoPage({Key? key})
      : super(key: key, name: 'QuizCadastroUnicoAtualizadoPage');

  @override
  State<QuizCadastroUnicoAtualizadoPage> createState() =>
      _QuizCadastroUnicoAtualizadoPageState();
}

class _QuizCadastroUnicoAtualizadoPageState
    extends State<QuizCadastroUnicoAtualizadoPage> {
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
          label: 'VER RESULTADO',
          onTap: () {
            var controller = _controller.quizStream.value;
            if (controller.possuiCadastroAtualizado == null) {
              NotificationService.negative('Selecione uma das opções');
              return;
            }
            AdManager.showRewarded(
                onDispose: () => push(context, QuizResultSecondPage()));
          },
          icon: const AdIcon(),
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
                onTap: () => push(context, QuizComoSaberCadUnicoPage())),
          ),
        ),
        const AppTitle('Você atualizou seu cadastro único nos últimos 2 anos?'),
        const H(16),
        QuizOptionWidget(
          options: quizOptions,
          option: model.possuiCadastroAtualizado,
          onChanged: (e) {
            model.possuiCadastroAtualizado = e;
            _controller.quizStream.update();
          },
        ),
        const H(24),
        const BannerWidget(),
      ],
    );
  }
}
