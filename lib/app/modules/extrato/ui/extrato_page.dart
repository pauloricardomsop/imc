import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/extensions.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/atendimento/topics/atendimento_presencial_page.dart';
import 'package:svr/app/modules/calendario/calendario_controller.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_controller.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_model.dart';
import 'package:svr/app/modules/extrato/extrato_controller.dart';
import 'package:svr/app/modules/saiba_voce_tem_direito/saiba_voce_tem_direito_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExtratoPage extends AdStatefulWidget {
  ExtratoPage({Key? key}) : super(key: key, name: 'ExtratoPage');

  @override
  State<ExtratoPage> createState() => _ExtratoPageState();
}

class _ExtratoPageState extends State<ExtratoPage> {
  ConsultaPagamentosController consultaPagamentoController =
      ConsultaPagamentosController();
  ExtratoController extratoController = ExtratoController();

  @override
  void initState() {
    extratoController.fecthBolsaFamilia(
        consultaPagamentoController.consultaPagamento.bolsaFamilia!.nis);
    super.initState();
  }

  List<CardFeature> get gridItens => [
        CardFeature(
            label: 'Saiba se você\ntem direito.',
            prefix: Symbols.tv_options_edit_channels,
            onTap: () => AdManager.showIntersticial(context,
                flow: AdFlow.going,
                onDispose: () => push(context, SaibaVoceTemDireitoHomePage()))),
        CardFeature(
          label: 'Encontre\num CRAS ',
          prefix: Symbols.map,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, AtendimentoPresencialPage())),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: StreamOut<ConsultaPagamentosModel>(
        stream: consultaPagamentoController.consultaPagamentoStream.listen,
        child: (_, consultaPagamento) => body(context, consultaPagamento),
      ),
    );
  }

  Widget body(_, ConsultaPagamentosModel consultaPagamentos) {
    return AppListView(
      children: [
        _header(
            consultaPagamentos,
            CalendarioController().getPaymentDate(
                consultaPagamentos.bolsaFamilia!.nis.characters.last)),
        _proximosPagamentosWidget(consultaPagamentos),
        const H(24),
        const BannerWidget(),
        const H(24),
        _pagamentosAnterioresWidget(consultaPagamentos),
        const H(24),
        const SelectYesNo(),
        const H(24),
        const AppTitle('Veja mais opções.'),
        const H(24),
        CardFeatures(gridItens),
      ],
    );
  }

  Header _header(
      ConsultaPagamentosModel consultaPagamentos, DateTime paymentDate) {
    return Header(
      child: Column(
        children: [
          const H(16),
          AppLabelValue('Beneficiário',
              consultaPagamentos.bolsaFamilia!.name.toTitleCase()),
          const H(12),
          AppLabelValue(
              'Município / UF', consultaPagamentos.bolsaFamilia!.address),
          const H(16),
          Row(
            children: [
              HeaderCard.text(
                label: 'Valor do\nBenefício',
                icon: Icons.attach_money,
                title: consultaPagamentos.bolsaFamilia!.valor.contains('R\$')
                    ? consultaPagamentos.bolsaFamilia!.valor
                    : 'R\$ ${consultaPagamentos.bolsaFamilia!.valor}',
                subtitle:
                    'Atualizado em ${DateFormat('MM/yy').format(consultaPagamentos.bolsaFamilia!.date)}',
              ),
              const W(8),
              HeaderCard.text(
                label: 'Próximo\nPagamento',
                icon: Icons.free_cancellation,
                title: DateFormat('d/MM/yy', 'pt_BR').format(paymentDate),
                subtitle: DateFormat('EEEE', 'pt_BR')
                    .format(paymentDate)
                    .toTitleCase()
                    .replaceAll('-', ' ')
                    .toTitleCase(),
              ),
              // HeaderCard.text(
              //   label: 'Próximo\nPagamento',
              //   icon: Icons.free_cancellation,
              //   title: DateFormat('EEEE, d', 'pt_BR')
              //       .format(paymentDate)
              //       .toTitleCase()
              //       .replaceAll('-feira', ''),
              //   subtitle:
              //       'de ${DateFormat('MMMM y', 'pt_BR').format(paymentDate)}',
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Column _proximosPagamentosWidget(ConsultaPagamentosModel consultaPagamentos) {
    final nextPayments = CalendarioController()
        .getNextPayments(consultaPagamentos.bolsaFamilia!.nis.characters.last);
    return Column(
      children: [
        const AppTitle('Próximos Pagamentos'),
        const H(16),
        CardInfos(
          nextPayments
              .map(
                (e) => CardInfo(
                  'Pagamento Agendado',
                  DateFormat("dd 'de' MMMM yyyy", 'pt_BR')
                      .format(e)
                      .toTitleCase(),
                  e == nextPayments.first
                      ? const AppIcon.freeCancelation()
                      : const AppIcon.eventUpcoming(),
                  isDark: e == nextPayments.first,
                ),
              )
              .toList(),
        )
      ],
    );
  }

  Column _pagamentosAnterioresWidget(
      ConsultaPagamentosModel consultaPagamentos) {
    final lastPayments = CalendarioController()
        .getLastPayments(consultaPagamentos.bolsaFamilia!.nis.characters.last);
    return Column(
      children: [
        const AppTitle('Pagamentos Anteriores'),
        const H(16),
        CardInfos(
          lastPayments
              .map(
                (e) => CardInfo(
                  'Pago em',
                  DateFormat("dd 'de' MMMM yyyy", 'pt_BR')
                      .format(e)
                      .toTitleCase(),
                  const AppIcon.eventAvailable(),
                ),
              )
              .toList(),
        )
      ],
    );
  }

  // Widget extratoItem(BuildContext context, BolsaFamiliaData data) {
  //   final monthReference = DateFormat('MM/yyyy').parse(data.mesReferencia);
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Row(
  //           children: [
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                       "Benefício - ${DateFormat('MMMM yyyy', 'pt_BR').format(monthReference).capitalize()}",
  //                       style: const TextStyle(
  //                         fontSize: 12,
  //                         fontWeight: FontWeight.w500,
  //                       )),
  //                   const H(2),
  //                   const Text("Novo Bolsa Família",
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w800,
  //                       ))
  //                 ],
  //               ),
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 const Text("Data",
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: FontWeight.w500,
  //                     )),
  //                 const H(2),
  //                 Text(
  //                     DateFormat('dd/MM/yyyy').format(CalendarioController()
  //                         .getPaymentDateByMonth(data.nis.characters.last, monthReference.month)),
  //                     style: const TextStyle(
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w800,
  //                     ))
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //       const Divisor(),
  //     ],
  //   );
  // }
}
