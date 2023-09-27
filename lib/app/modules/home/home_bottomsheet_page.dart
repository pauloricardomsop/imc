import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_controller.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_model.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class HomeBottomSheetPage extends StatelessWidget {
  const HomeBottomSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    ConsultaPagamentosController consultaPagamentoController =
        ConsultaPagamentosController();
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        child: StreamOut<ConsultaPagamentosModel>(
          stream: consultaPagamentoController.consultaPagamentoStream.listen,
          child: (_, consultaPagamento) =>
              body(context, consultaPagamento, consultaPagamentoController),
        ),
      ),
    );
  }

  Widget body(BuildContext context, ConsultaPagamentosModel consultaPagamento,
      ConsultaPagamentosController consultaPagamentoController) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 8),
          Text('Excluindo NIS',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.onSurface)
                  .headlineSmall
                  .copyWith(fontWeight: FontWeight.w900)),
          const H(16),
          AppDesc(consultaPagamento.bolsaFamilia!.nis.toString()),
          const H(16),
          Text(
            'Ao remover seu NIS, as informações do seu benefício serão apagadas deste dispositivo. Para consultar seu Bolsa Família, você terá que realizar uma nova consulta através de seu NIS. Tem certeza de que quer apagar seu NIS?',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.onSurface).bodyLarge,
          ),
          const H(16),
          AppButton(
              label: 'CONTINUAR COM NIS', onTap: () => Navigator.pop(context)),
          const H(16),
          AppButton.textButtons(
            label: 'REMOVER NIS',
            onTap: () async {
              Navigator.pop(context);
              await Future.delayed(const Duration(milliseconds: 500));
              consultaPagamentoController.onClickDeleteBolsaFamiliaViewModel();
            },
            icon: Symbols.delete,
          ),
          const H(16),
        ],
      ),
    );
  }
}
