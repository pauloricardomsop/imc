import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/quiz_controller.dart';
import 'package:svr/app/modules/quiz/quiz_model.dart';
import 'package:svr/app/modules/quiz/ui/quiz_alguem_possui_mei_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class QuizQuantidadePessoasPage extends AdStatefulWidget {
  QuizQuantidadePessoasPage({Key? key})
      : super(key: key, name: 'QuizQuantidadePessoasPage');

  @override
  State<QuizQuantidadePessoasPage> createState() =>
      _QuizQuantidadePessoasPageState();
}

class _QuizQuantidadePessoasPageState extends State<QuizQuantidadePessoasPage> {
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
            if (controller.quantidadePessoas == 0) {
              NotificationService.negative('Número de pessoas inválido');
              return;
            }
            push(context, QuizAlguemPossuiMeiPage());
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
            backgroundColor: const Color(0xFFF8FAFC),
            leading: const AppIcon.back(
                backgroundColor: AppColors.surfaceContainer,
                iconColor: AppColors.onSurface),
            action: AppIcon.logout(onTap: () => pops(context, 2)),
          ),
        ),
        const AppTitle('Quantas pessoas moram em sua residência?'),
        const H(16),
        AppFieldCounter(
          onChanged: (e) {
            model.quantidadePessoas = e;
            _controller.quizStream.update();
          },
        ),
        const H(24),
        const BannerWidget(),
      ],
    );
  }
}
