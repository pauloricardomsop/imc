import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_controller.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_model.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class ConsultaCpfAtivoErrorPage extends AdStatefulWidget {
  ConsultaCpfAtivoErrorPage({Key? key})
      : super(key: key, name: 'ConsultaCpfAtivoErrorPage');

  @override
  State<ConsultaCpfAtivoErrorPage> createState() =>
      _ConsultaCpfAtivoErrorPage();
}

class _ConsultaCpfAtivoErrorPage extends State<ConsultaCpfAtivoErrorPage> {
  final ConsultaPagamentosController _controller =
      ConsultaPagamentosController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamOut<ConsultaPagamentosModel>(
        stream: _controller.consultaPagamentoStream.listen,
        child: (_, model) => body(context, model),
      ),
    );
  }

  Widget body(_, ConsultaPagamentosModel model) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + 28, bottom: 28),
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(color: AppColors.warning),
          child: Text('Data de nascimento incorreta.',
              style: const TextStyle(color: AppColors.onWarning).titleSmall),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Expanded(
            child: AppImage(
              url: 'assets/images/errordate.svg',
              isSVG: true,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const H(16),
              Text(
                'Erro na data de\nnascimento',
                textAlign: TextAlign.center,
                style: const TextStyle().displaySmall,
              ),
              const H(16),
              Text(
                'A data de nascimento informada não corresponde ao CPF.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.onSurfaceVariant)
                    .bodyLarge,
              ),
              const H(24),
              AppButton(
                label: 'TENTAR NOVAMENTE',
                icon: const AdIcon(),
                onTap: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
