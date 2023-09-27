import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/solucionando_divergencias/solucionando_divergencias_controller.dart';
import 'package:svr/app/modules/solucionando_divergencias/solucionando_divergencias_model.dart';
import 'package:svr/app/modules/solucionando_divergencias/ui/solucionando_divergencias_resultado_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class SolucionandoDivergenciasQuantidadeGestantesPage extends AdStatefulWidget {
  SolucionandoDivergenciasQuantidadeGestantesPage({Key? key})
      : super(
            key: key, name: 'SolucionandoDivergenciasQuantidadeGestantesPage');

  @override
  State<SolucionandoDivergenciasQuantidadeGestantesPage> createState() =>
      _SolucionandoDivergenciasQuantidadeGestantesPageState();
}

class _SolucionandoDivergenciasQuantidadeGestantesPageState
    extends State<SolucionandoDivergenciasQuantidadeGestantesPage> {
  final SolucionandoDivergenciasController _controller =
      SolucionandoDivergenciasController();

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
          onTap: () => AdManager.showRewarded(
              onDispose: () =>
                  push(context, SolucionandoDivergenciasResultadoPage())),
          icon: const AdIcon(),
        ),
      ),
      child: StreamOut<SolucionandoDivergenciasQuiz>(
        stream: _controller.quizStream.listen,
        child: (_, model) => body(context, model),
      ),
    );
  }

  Widget body(_, SolucionandoDivergenciasQuiz model) {
    return AppListView(
      children: [
        const Header.light(),
        const HeaderTextLight('Quantas mulheres gestantes moram em sua casa?',
            'Caso não morem mulheres gestantes em sua casa deixe 0 (zero) no campo.'),
        AppFieldCounter(
          onChanged: (e) {
            model.qntdGestantesController = e;
            _controller.quizStream.update();
          },
        ),
        const H(24),
        const BannerWidget(),
        const H(24),
      ],
    );
  }
}
