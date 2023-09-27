import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/solucionando_divergencias/solucionando_divergencias_controller.dart';
import 'package:svr/app/modules/solucionando_divergencias/solucionando_divergencias_model.dart';
import 'package:svr/app/modules/solucionando_divergencias/ui/solucionando_divergencias_0_a_6_page.dart';
import 'package:svr/app/modules/solucionando_divergencias/ui/solucionando_divergencias_quantidade_gestantes_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SolucionandoDivergenciasQuantidadeFilhosPage extends AdStatefulWidget {
  SolucionandoDivergenciasQuantidadeFilhosPage({Key? key})
      : super(key: key, name: 'SolucionandoDivergenciasQuantidadeFilhosPage');

  @override
  State<SolucionandoDivergenciasQuantidadeFilhosPage> createState() =>
      _SolucionandoDivergenciasQuantidadeFilhosPageState();
}

class _SolucionandoDivergenciasQuantidadeFilhosPageState
    extends State<SolucionandoDivergenciasQuantidadeFilhosPage> {
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
          label: 'PRÓXIMO',
          onTap: () {
            var controller = _controller.quizStream.value;
            if (controller.qntdFilhos == null) {
              NotificationService.negative('Selecione uma das opções');
              return;
            }
            (controller.possuiFilhos)
                ? AdManager.showIntersticial(context,
                    onDispose: () =>
                        push(context, SolucionandoDivergencias0a6Page()))
                : AdManager.showIntersticial(context,
                    onDispose: () => push(context,
                        SolucionandoDivergenciasQuantidadeGestantesPage()));
          },
          icon: Symbols.trending_flat,
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
        const AppTitle('Você tem filhos morando em sua casa?'),
        const H(16),
        QuizOptionWidget(
          options: quizOptions,
          option: model.qntdFilhos,
          onChanged: (e) {
            model.qntdFilhos = e;
            _controller.quizStream.update();
          },
        ),
        const H(24),
        const BannerWidget()
      ],
    );
  }
}
