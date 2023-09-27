import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/atendimento/atendimento_home_page.dart';
import 'package:svr/app/modules/consulta_nis/ui/consulta_nis_home_page.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_controller.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_model.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConsultaPagamentosErrorPage extends AdStatefulWidget {
  ConsultaPagamentosErrorPage({Key? key})
      : super(key: key, name: 'ConsultaPagamentosErrorPage');

  @override
  State<ConsultaPagamentosErrorPage> createState() =>
      _ConsultaPagamentosErrorPageState();
}

class _ConsultaPagamentosErrorPageState
    extends State<ConsultaPagamentosErrorPage> {
  final ConsultaPagamentosController _controller =
      ConsultaPagamentosController();

  List<CardFeature> get gridItens => [
        CardFeature(
          label: 'Encontre seu NIS\ncom CPF',
          prefix: Symbols.data_loss_prevention,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, ConsultaNisHomePage())),
        ),
        CardFeature(
          label: 'Canais de\nAtendimento',
          prefix: Symbols.support_agent,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, AtendimentoHomePage())),
        ),
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
    return ListView(
      children: [
        //TODO: Implementar Header
        // Header(
        //   type: HeaderType.home,
        //   iconColor: AppColors.onWarningContainer,
        //   color: AppColors.errorContainer,
        //   backgroundColor: AppColors.error,
        //   texts: Text(
        //     'Beneficiário não encontrado.',
        //     style: AppTheme.text.normal.ts(
        //       AppColors.onWarning,
        //     ),
        //   ),
        //   textColor: AppColors.white,
        //   onTap: () => Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ConsultaPagamentosHomePage(),
        //     ),
        //     (route) => false,
        //   ),
        // ),
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: AppImage(
                url: 'assets/images/pana_error.svg',
                isSVG: true,
                fit: BoxFit.contain,
              ),
            ),
            const H(16),
            _buildTextComponents('NIS: ${model.nis.text}',
                'Não encontramos beneficiários com \no NIS informado no Portal da Transparência. Verifique se o NIS informado está correto e tente novamente.'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AppButton(
                    label: 'TENTAR NOVAMENTE',
                    onTap: () {
                      Navigator.pop(context);
                      _controller.onClickConsultar(context);
                    },
                  ),
                  const H(24),
                  textTitlePage('Outras opções'),
                  const H(16),
                  const BannerWidget(),
                  const H(24),
                  CardFeatures(gridItens)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget textTitlePage(String text) {
    return Row(
      children: [
        Text(
          text,
          textAlign: TextAlign.left,
          style: const TextStyle(color: AppColors.onSurface).titleLarge,
        ),
      ],
    );
  }

  Widget _buildTextComponents(String label, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle().titleLarge,
          ),
          const H(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle().bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
