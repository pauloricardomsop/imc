import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/atendimento/atendimento_home_page.dart';
import 'package:svr/app/modules/consulta_nis/ui/consulta_nis_home_page.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_controller.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_model.dart';
import 'package:svr/app/modules/home/home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConsultaPagamentoNaoEncontradoPage extends AdStatefulWidget {
  ConsultaPagamentoNaoEncontradoPage({Key? key})
      : super(key: key, name: 'ConsultaPagamentosErrorPage');

  @override
  State<ConsultaPagamentoNaoEncontradoPage> createState() =>
      _ConsultaPagamentosIndisponivelPageState();
}

class _ConsultaPagamentosIndisponivelPageState
    extends State<ConsultaPagamentoNaoEncontradoPage> {
  final ConsultaPagamentosController _controller =
      ConsultaPagamentosController();

  List<CardFeature> get cardItens => [
        CardFeature(
          label: 'Encontre seu NIS\ncom CPF',
          prefix: Symbols.data_loss_prevention,
          onTap: () => push(context, ConsultaNisHomePage()),
        ),
        CardFeature(
          label: 'Canais de\nAtendimento',
          prefix: Symbols.support_agent,
          onTap: () => push(context, AtendimentoHomePage()),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: StreamOut<ConsultaPagamentosModel>(
        stream: _controller.consultaPagamentoStream.listen,
        child: (_, model) => body(context, model),
      ),
    );
  }

  Widget body(_, ConsultaPagamentosModel model) {
    return AppListView(
      padding: EdgeInsets.zero,
      children: [
        HeaderTop(
          leading: AppIcon.home(
              iconColor: const Color(0xFFFEE2E2),
              backgroundColor: const Color(0xFF991B1B),
              onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false,
                  )),
          backgroundColor: const Color(0xFFDC2626),
          child: Text(
            'O Portal da Transparência não está respondendo, volte mais tarde.',
            style: const TextStyle(color: Color(0xFFFEF2F2)).titleSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const AppImage(
                url: 'assets/images/pana_error.svg',
                isSVG: true,
                fit: BoxFit.contain,
              ),
              const H(24),
              Text(
                'NIS: ${model.nis.text}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.onSurface).titleLarge,
              ),
              const H(8),
              Text(
                'Não encontramos beneficiários com o NIS informado no Portal da Transparência. Verifique se o NIS informado está correto e tente novamente. ',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.onSurface).bodyMedium,
              ),
              const H(32),
              AppButton(
                label: 'TENTAR NOVAMENTE',
                onTap: () => Navigator.pop(context),
              ),
              const H(24),
              const AppTitle('Outras opções'),
              const H(24),
              const BannerWidget(),
              const H(24),
              CardFeatures(cardItens)
            ],
          ),
        )
      ],
    );
  }
}
