import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/quiz_controller.dart';
import 'package:svr/app/modules/quiz/quiz_model.dart';
import 'package:svr/app/modules/quiz/ui/quiz_cartao_vacina_filhos_0a6_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class QuizQuantidadeFilhosPage extends AdStatefulWidget {
  QuizQuantidadeFilhosPage({Key? key})
      : super(key: key, name: 'QuizQuantidadeFilhosPage');

  @override
  State<QuizQuantidadeFilhosPage> createState() =>
      _QuizQuantidadeFilhosPageState();
}

class _QuizQuantidadeFilhosPageState extends State<QuizQuantidadeFilhosPage> {
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
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () => push(context, QuizCartaoVacinaFilhos0a6Page())),
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
            action: AppIcon.logout(onTap: () => pops(context, 5)),
          ),
        ),
        const AppTitle('Quantos filhos moram em sua residência?'),
        const H(16),
        const AppDesc('Quantos filhos de 4 a 6 anos?'),
        const H(8),
        AppFieldCounter(
          onChanged: (e) {
            model.quantidadeFilhos0a4 = e;
            _controller.quizStream.update();
          },
        ),
        const H(24),
        const AppDesc('Quantos filhos de 4 a 6 anos?'),
        const H(8),
        AppFieldCounter(
          onChanged: (e) {
            model.quantidadeFilhos4a6 = e;
            _controller.quizStream.update();
          },
        ),
        const H(24),
        const AppDesc('Quantos filhos de 7 a 18 anos?'),
        const H(8),
        AppFieldCounter(
          onChanged: (e) {
            model.quantidadeFilhos7a18 = e;
            _controller.quizStream.update();
          },
        ),
      ],
    );
  }
}
