import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_controller.dart';
import 'package:svr/app/modules/extrato/ui/extrato_page.dart';
import 'package:svr/app/modules/home/home_page.dart';
import 'package:svr/app/modules/solucionando_divergencias/ui/solucionando_divergencias_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

import '../../../core/client/providers/portal_transparencia/models/bolsa_familia.dart';

class ConsultaPagamentosSuccessPage extends AdStatefulWidget {
  final BolsaFamilia bolsaFamilia;
  ConsultaPagamentosSuccessPage(this.bolsaFamilia, {Key? key})
      : super(key: key, name: 'ConsultaPagamentosSuccessPage');

  @override
  State<ConsultaPagamentosSuccessPage> createState() =>
      _ConsultaPagamentosSuccessPageState();
}

class _ConsultaPagamentosSuccessPageState
    extends State<ConsultaPagamentosSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Beneficiário encontrado.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.onSurface).bodyMedium,
          ),
          const Expanded(
            child: AppImage(
              url: 'assets/images/rafiki.svg',
              isSVG: true,
              fit: BoxFit.contain,
            ),
          ),
          const H(16),
          Text(
            'Valor do seu Bolsa Família',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.onSurfaceVariant).bodyLarge,
          ),
          Text(
            'R\$ ${widget.bolsaFamilia.data.last.valorTotalPeriodo}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.onSurface).displayMedium,
          ),
          const H(24),
          const Divisor(),
          const H(24),
          SelectYesNo(
            question: 'O valor está correto?',
            onNo: () {
              ConsultaPagamentosController().removeBolsaFamiliaResult();
              push(
                context,
                SolucionandoDivergenciasHomePage(widget.bolsaFamilia),
              );
            },
            onYes: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
                (route) => false,
              );
              AdManager.showIntersticial(context,
                  onDispose: () => push(context, ExtratoPage()));
            },
          ),
        ],
      ),
    );
  }
}
