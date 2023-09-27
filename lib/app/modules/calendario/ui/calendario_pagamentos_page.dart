import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/utils/extensions.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/atendimento/atendimento_home_page.dart';
import 'package:svr/app/modules/atendimento/topics/atendimento_presencial_page.dart';
import 'package:svr/app/modules/calendario/calendario_controller.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class CalendarioPagamentosPage extends AdStatefulWidget {
  final int nis;

  CalendarioPagamentosPage(this.nis, {Key? key})
      : super(key: key, name: 'CalendarioPagamentosPage');

  @override
  State<CalendarioPagamentosPage> createState() =>
      _CalendarioProximosPagamentosPageState();
}

class _CalendarioProximosPagamentosPageState
    extends State<CalendarioPagamentosPage> {
  final CalendarioController _calendarioController = CalendarioController();

  late List<DateTime> nextDates;
  late List<DateTime> lastDates;

  @override
  void initState() {
    nextDates = _calendarioController.getNextPayments(widget.nis);
    lastDates = _calendarioController.getLastPayments(widget.nis);
    super.initState();
  }

  List<CardFeature> get gridItens => [
        CardFeature(
          label: 'Encontre\num CRAS ',
          prefix: Symbols.map,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, AtendimentoPresencialPage())),
        ),
        CardFeature(
          label: 'Canais de\nAtendimento',
          prefix: Symbols.support_agent,
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () => push(context, AtendimentoHomePage())),
        )
      ];

  @override
  Widget build(BuildContext context) {
    final paymentDate = CalendarioController().getPaymentDate(widget.nis);
    return AppScaffold(
        child: AppListView(
      children: [
        _header(paymentDate),
        _proximosPagamentosWidget(
            CalendarioController().getNextPayments(widget.nis)),
        const H(24),
        const BannerWidget(),
        const H(24),
        _pagamentosAnterioresWidget(
            CalendarioController().getNextPayments(widget.nis)),
        const H(24),
        const SelectYesNo(),
        const H(24),
        const AppTitle('Veja mais opções.'),
        const H(24),
        CardFeatures(gridItens),
      ],
    ));
  }

  Header _header(DateTime paymentDate) {
    return Header(
      child: Row(
        children: [
          HeaderCard.action(
            label: 'Final do\nNIS',
            title: widget.nis.toString(),
            icon: Icons.password,
            action: const AppIcon.none(),
          ),
          const W(8),
          HeaderCard.text(
            label: 'Próximo\nPagamento',
            icon: Icons.free_cancellation,
            title: DateFormat('EEEE, d', 'pt_BR')
                .format(paymentDate)
                .toTitleCase()
                .replaceAll('-feira', ''),
            subtitle: 'de ${DateFormat('MMMM y', 'pt_BR').format(paymentDate)}',
          ),
        ],
      ),
    );
  }

  Column _proximosPagamentosWidget(List<DateTime> dates) {
    return Column(
      children: [
        const AppTitle('Próximos Pagamentos'),
        const H(16),
        CardInfos(
          dates
              .map(
                (e) => CardInfo(
                  'Pagamento Agendado',
                  DateFormat("dd 'de' MMMM yyyy", 'pt_BR')
                      .format(e)
                      .toTitleCase(),
                  e == dates.first
                      ? const AppIcon.freeCancelation()
                      : const AppIcon.eventUpcoming(),
                  isDark: e == dates.first,
                ),
              )
              .toList(),
        )
      ],
    );
  }

  Column _pagamentosAnterioresWidget(List<DateTime> dates) {
    return Column(
      children: [
        const AppTitle('Pagamentos Anteriores'),
        const H(16),
        CardInfos(
          dates
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
}
