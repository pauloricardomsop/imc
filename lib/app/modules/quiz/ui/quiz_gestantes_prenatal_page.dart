import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/quiz_controller.dart';
import 'package:svr/app/modules/quiz/quiz_model.dart';
import 'package:svr/app/modules/quiz/ui/quiz_cadastro_unico_atualizado_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class QuizGestantesPreNatalPage extends AdStatefulWidget {
  QuizGestantesPreNatalPage({Key? key})
      : super(key: key, name: 'QuizGestantesPreNatalPage');

  @override
  State<QuizGestantesPreNatalPage> createState() =>
      _QuizGestantesPreNatalPageState();
}

class _QuizGestantesPreNatalPageState extends State<QuizGestantesPreNatalPage> {
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
            if (controller.possuiGestantePreNatalEmDia == null) {
              NotificationService.negative('Selecione uma das opções');
              return;
            }
            push(context, QuizCadastroUnicoAtualizadoPage());
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
            action: AppIcon.logout(onTap: () => pops(context, 9)),
          ),
        ),
        const AppTitle('A gestante está com pré-natal em dias?'),
        const H(16),
        QuizOptionWidget(
          options: quizOptions,
          option: model.possuiGestantePreNatalEmDia,
          onChanged: (e) {
            model.possuiGestantePreNatalEmDia = e;
            _controller.quizStream.update();
          },
        ),
        const H(24),
        const BannerWidget(),
      ],
    );
  }
}
