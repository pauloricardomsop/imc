import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_controller.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_model.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class ConsultaPagamentosIndisponivelPage extends AdStatefulWidget {
  ConsultaPagamentosIndisponivelPage({Key? key})
      : super(key: key, name: 'ConsultaPagamentosIndisponivelPage');

  @override
  State<ConsultaPagamentosIndisponivelPage> createState() =>
      _ConsultaPagamentosErrorPageState();
}

class _ConsultaPagamentosErrorPageState
    extends State<ConsultaPagamentosIndisponivelPage> {
  final ConsultaPagamentosController _controller =
      ConsultaPagamentosController();

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
    return Column(
      children: [
        CardAlert.warningTop(
            'O Portal da Transparência não está respondendo, volte mais tarde.',
            const TextStyle(color: AppColors.onError).titleSmall),
        const Expanded(
          child: AppImage(
            url: 'assets/images/pana.svg',
            isSVG: true,
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const H(16),
              Text(
                'Serviço\nIndisponível',
                textAlign: TextAlign.center,
                style: const TextStyle().displaySmall,
              ),
              const H(16),
              Text(
                'Os serviços do Portal da Transparência estão temporariamente indisponíveis.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.onSurfaceVariant)
                    .bodyLarge,
              ),
              const H(24),
              AppButton(
                label: 'TENTAR NOVAMENTE',
                icon: const AdIcon(),
                onTap: () {
                  Navigator.pop(context);
                  _controller.onClickConsultar(context);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
