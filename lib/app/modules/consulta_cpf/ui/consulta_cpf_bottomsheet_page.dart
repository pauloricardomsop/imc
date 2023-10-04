import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/client/cpf_captcha/models/cpf_captcha_situacao_model.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_cpf/consulta_cpf_controller.dart';
import 'package:svr/app/modules/consulta_cpf/consulta_cpf_model.dart';

class ConsultaCPFBottomSheetPage extends StatelessWidget {
  final CPFCaptchaSituacaoModel model;
  final DateTime now;
  const ConsultaCPFBottomSheetPage(this.model, this.now, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConsultaCPFController consultaPagamentoController = ConsultaCPFController();
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
        child: StreamOut<ConsultaCPFModel>(
          stream: consultaPagamentoController.consultaStream.listen,
          child: (_, consultaPagamento) =>
              body(context, consultaPagamento, consultaPagamentoController),
        ),
      ),
    );
  }

  Widget body(BuildContext context, ConsultaCPFModel consultaPagamento,
      ConsultaCPFController consultaPagamentoController) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFC8C5C9),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const H(8),
          camposUser('Nome completo', model.nome),
          const H(8),
          camposUser('Data de Nascimento', model.dataNascimento),
          const H(8),
          camposUser('CPF', model.cpf),
          const H(8),
          camposUser('Data de inscrição', model.dataInscricao),
          const H(8),
          camposUser('Código de verificação', model.codigoControleComprovante, isCopy: true),
          const H(8),
          camposUser('Dígito Verificador', model.digitoVerificador),
          const H(8),
          Text(
            'Comprovante emitido às ${DateFormat('H:m:s', 'pt_BR').format(now)} do dia\n${DateFormat('d/MM/yyyy', 'pt_BR').format(now)} (hora e data de Brasília).',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF020617)).bodyMedium,
          ),
          const H(8),
          AppButton.forward(
            label: 'ESCONDER DETALHES',
            onTap: () => Navigator.pop(context),
            icon: Symbols.arrow_downward_alt,
            foregroundColor: AppColors.primary,
            backgroundColor: AppColors.surfaceContainerLowest,
            labelColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget camposUser(String label, String value, {bool isCopy = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 1.50,
            letterSpacing: 0.50,
          ),
        ),
        const H(4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF020617),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.50,
                letterSpacing: 0.15,
              ),
            ),
            (isCopy)
                ? Row(
                    children: [
                      const H(8),
                      AppIcon(
                        icon: Symbols.content_copy,
                        onTap: () => copyClipboard(value),
                        iconColor: AppColors.primary,
                        backgroundColor: AppColors.surfaceContainerLowest,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
