import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/solucionando_divergencias/solucionando_divergencias_controller.dart';
import 'package:svr/app/modules/solucionando_divergencias/solucionando_divergencias_model.dart';
import 'package:svr/app/modules/solucionando_divergencias/ui/solucionando_divergencias_quantidade_gestantes_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SolucionandoDivergencias7a18Page extends AdStatefulWidget {
  SolucionandoDivergencias7a18Page({Key? key})
      : super(key: key, name: 'SolucionandoDivergencias7a18Page');

  @override
  State<SolucionandoDivergencias7a18Page> createState() =>
      _SolucionandoDivergencias7a18PageState();
}

class _SolucionandoDivergencias7a18PageState
    extends State<SolucionandoDivergencias7a18Page> {
  final SolucionandoDivergenciasController _controller =
      SolucionandoDivergenciasController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(
        AppButton(
          label: 'PRÓXIMO',
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () => push(
                  context, SolucionandoDivergenciasQuantidadeGestantesPage())),
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
        const HeaderTextLight('Você tem filhos com idade entre 7 e 18 anos?',
            'Caso não tenha filhos, deixe 0 (zero) no campo abaixo.'),
        AppFieldCounter(
          onChanged: (e) {
            model.qntdFilhos7a18Controller = e;
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
