import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/quiz_controller.dart';
import 'package:svr/app/modules/quiz/quiz_model.dart';
import 'package:svr/app/modules/quiz/topics/quiz_regras_frenquencia_escolar_page.dart';
import 'package:svr/app/modules/quiz/ui/quiz_quantidade_gestante_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class QuizMatriculados4a18Page extends AdStatefulWidget {
  QuizMatriculados4a18Page({Key? key})
      : super(key: key, name: 'QuizMatriculados4a18Page');

  @override
  State<QuizMatriculados4a18Page> createState() =>
      _QuizMatriculados4a18PageState();
}

class _QuizMatriculados4a18PageState extends State<QuizMatriculados4a18Page> {
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
            if (controller.possuiFilhos4a18FrequentandoEscola == null) {
              NotificationService.negative('Selecione uma das opções');
              return;
            }
            AdManager.showIntersticial(context,
                onDispose: () => push(context, QuizQuantidadeGestantesPage()));
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
                onTap: () => push(context, QuizRegrasFrequenciaEscolarPage())),
          ),
        ),
        const AppTitle(
            'Seus filhos de 4 a 18 anos incompletos estão matriculados e frequentando a escola?'),
        const H(16),
        QuizOptionWidget(
          options: quizOptions,
          option: model.possuiFilhos4a18FrequentandoEscola,
          onChanged: (e) {
            model.possuiFilhos4a18FrequentandoEscola = e;
            _controller.quizStream.update();
          },
        ),
        const H(24),
        const BannerWidget(),
      ],
    );
  }
}
