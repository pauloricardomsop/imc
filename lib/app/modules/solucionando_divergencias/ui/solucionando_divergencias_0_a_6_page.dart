import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/solucionando_divergencias/solucionando_divergencias_controller.dart';
import 'package:svr/app/modules/solucionando_divergencias/solucionando_divergencias_model.dart';
import 'package:svr/app/modules/solucionando_divergencias/ui/solucionando_divergencias_7_a_18_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SolucionandoDivergencias0a6Page extends AdStatefulWidget {
  SolucionandoDivergencias0a6Page({Key? key})
      : super(key: key, name: 'SolucionandoDivergencias0a6Page');

  @override
  State<SolucionandoDivergencias0a6Page> createState() =>
      _SolucionandoDivergencias0a6PageState();
}

class _SolucionandoDivergencias0a6PageState
    extends State<SolucionandoDivergencias0a6Page> {
  final SolucionandoDivergenciasController _controller =
      SolucionandoDivergenciasController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(
        AppButton(
          label: 'PRÓXIMO',
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () =>
                  push(context, SolucionandoDivergencias7a18Page())),
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
        const HeaderTextLight('Você tem filhos com idade entre 0 e 6 anos?',
            'Caso não tenha filhos, deixe 0 (zero) no campo abaixo.'),
        AppFieldCounter(
          onChanged: (e) {
            model.qntdFilhos0a6Controller = e;
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
