import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/components/stream_out.dart';

import 'package:svr/app/core/utils/extensions.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/atendimento/atendimento_home_page.dart';
import 'package:svr/app/modules/calendario/calendario_controller.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_controller.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_model.dart';
import 'package:svr/app/modules/extrato/ui/extrato_page.dart';
import 'package:svr/app/modules/home/home_page.dart';
import 'package:svr/app/modules/solucionando_divergencias/solucionando_divergencias_controller.dart';
import 'package:svr/app/modules/solucionando_divergencias/solucionando_divergencias_model.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class SolucionandoDivergenciasResultadoPage extends AdStatefulWidget {
  SolucionandoDivergenciasResultadoPage({Key? key})
      : super(key: key, name: 'SolucionandoDivergenciasResultadoPage');

  @override
  State<SolucionandoDivergenciasResultadoPage> createState() =>
      _SolucionandoDivergenciasResultadoPageState();
}

class _SolucionandoDivergenciasResultadoPageState
    extends State<SolucionandoDivergenciasResultadoPage> {
  final SolucionandoDivergenciasController _controllerSolucionando =
      SolucionandoDivergenciasController();
  final ConsultaPagamentosController _controllerPagamentos =
      ConsultaPagamentosController();

  List<CardFeature> get gridItens => [
        CardFeature.full(
          label: 'Canais de\nAtendimento',
          prefix: Symbols.support_agent,
          onTap: () => push(context, AtendimentoHomePage()),
        ),
      ];

  List<CardMoney> get _cardsMoney {
    final model = _controllerSolucionando.quizStream.value;
    return [
      CardMoney(
        'Benefício de\nRenda e Cidadania',
        toMoney(model.beneficioRendaCidadania),
        valueColor: const Color(0xFF020617),
      ),
      CardMoney('Benefício\nVariável Familiar',
          '+ ${toMoney(model.beneficioVariavelFamiliar)}'),
      CardMoney('Benefício\nPrimeira Infância',
          '+ ${toMoney(model.beneficioPrimeiraInfancia)}'),
      CardMoney(
        'Total do Bolsa Família',
        '+ ${toMoney(model.totalBolsaFamilia)}',
        isDark: true,
      ),
    ];
  }

  @override
  void initState() {
    ConsultaPagamentosController()
        .updateBolsaFamiliaFromSolucionandoDivergencias(
            _controllerSolucionando.quizStream.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (route) => false);
        return Future.value(true);
      },
      bottom: Footer(AppButton(
        label: 'VER CALENDÁRIO',
        onTap: () => AdManager.showRewarded(
          //TODO: Adicionar o calendario
          onDispose: () => push(context, ExtratoPage()),
        ),
        icon: const AdIcon(),
      )),
      child: StreamOut<ConsultaPagamentosModel>(
        stream: _controllerPagamentos.consultaPagamentoStream.listen,
        child: (_, result) => StreamOut<SolucionandoDivergenciasQuiz>(
          stream: _controllerSolucionando.quizStream.listen,
          child: (_, model) => body(context, model, result),
        ),
      ),
    );
  }

  Widget body(_, SolucionandoDivergenciasQuiz model,
      ConsultaPagamentosModel consultaPagamentos) {
    return AppListView(
      children: [
        _header(
            consultaPagamentos,
            CalendarioController().getPaymentDate(
                consultaPagamentos.bolsaFamilia!.nis.characters.last)),
        const AppTitle('Resumo do Recalculo'),
        const H(24),
        const BannerWidget(),
        const H(16),
        CardMoneys(_cardsMoney),
        const H(16),
        const SelectYesNo(),
        const H(24),
        const AppTitle('Atenção!'),
        const H(16),
        const AppDesc(
            'Este recalculo é feito através de suas respostas e com base nas regras dos benefícios de:  Renda e Cidadania, Complementar, Variável Familiar e Primeira Infância, descritas no Novo Bolsa Família. \n\nCaso ainda encontre divergência de informações, busque atendimento oficial através de um dos canais de atendimento do Bolsa Família.'),
        const H(16),
        CardFeatures.full(gridItens)
      ],
    );
  }

  Header _header(
      ConsultaPagamentosModel consultaPagamentos, DateTime paymentDate) {
    return Header(
      top: HeaderTop(
        leading: AppIcon.home(
            iconColor: const Color(0xFFE0F2FE),
            backgroundColor: const Color(0xFF075985),
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()),
                (route) => false)),
        child: Text(
          'Recalculamos o valor do seu\nBenefício Bolsa Família!',
          style: const TextStyle(color: Color(0xFFF8FAFC)).bodyLarge,
        ),
      ),
      child: Column(
        children: [
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
                title: DateFormat('d/MM/y', 'pt_BR').format(paymentDate),
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
}
