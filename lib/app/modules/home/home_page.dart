import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/exit_banner.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/atendimento/atendimento_home_page.dart';
import 'package:svr/app/modules/atendimento/topics/atendimento_presencial_page.dart';
import 'package:svr/app/modules/calculadora_renda/calculadora_renda_home_page.dart';
import 'package:svr/app/modules/calculadora_valores/calculadora_valores_home_page.dart';
import 'package:svr/app/modules/calendario/ui/calendario_home_page.dart';
import 'package:svr/app/modules/como_funciona/como_funciona_home_page.dart';
import 'package:svr/app/modules/consulta_cpf_ativo/consulta_cpf_ativo_home_page.dart';
import 'package:svr/app/modules/consulta_nis/ui/consulta_nis_home_page.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_controller.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_model.dart';
import 'package:svr/app/modules/consulta_pagamentos/ui/consulta_pagamentos_home_page.dart';
import 'package:svr/app/modules/extrato/ui/extrato_page.dart';
import 'package:svr/app/modules/home/home_bottomsheet_page.dart';
import 'package:svr/app/modules/noticias/noticias_controller.dart';
import 'package:svr/app/modules/noticias/noticias_home_page.dart';
import 'package:svr/app/modules/saiba_voce_tem_direito/saiba_voce_tem_direito_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends AdStatefulWidget {
  HomePage({Key? key}) : super(key: key, name: 'HomePage');

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConsultaPagamentosController consultaPagamentoController =
      ConsultaPagamentosController();
  final NoticiasController _noticiasController = NoticiasController();
  bool isProcessing = false;

  @override
  void initState() {
    consultaPagamentoController.init();
    _noticiasController.init();
    super.initState();
  }

  List<CardFeature> get cardItens => [
        CardFeature(
          label: 'Saiba se você\ntem direito.',
          prefix: Symbols.tv_options_edit_channels,
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () => push(context, SaibaVoceTemDireitoHomePage())),
        ),
        CardFeature(
          label: 'Encontre seu NIS\ncom CPF',
          prefix: Symbols.data_loss_prevention,
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () => push(context, ConsultaNisHomePage())),
        ),
        CardFeature(
          label: 'Calendário de\nPagamentos',
          prefix: Symbols.free_cancellation,
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () => push(context, CalendarioHomePage())),
        ),
        CardFeature(
          label: 'Saiba se seu CPF\nestá ativo',
          prefix: Symbols.assured_workload,
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () => push(context, ConsultaCpfAtivoHomePage())),
        ),
        CardFeature(
          label: 'Calculadora de\nRenda',
          prefix: Symbols.calculate,
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () => push(context, CalculadoraRendaHomePage())),
        ),
        CardFeature(
          label: 'Simular valores do\nBolsa Família',
          prefix: Symbols.attach_money,
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () => push(context, CalculadoraValoresHomePage())),
        ),
        CardFeature(
          label: 'Encontrar um\nCRAS',
          prefix: Symbols.pin_drop,
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () => push(context, AtendimentoPresencialPage())),
        ),
        CardFeature(
          label: 'Como funciona e\nvalores',
          prefix: Symbols.library_books,
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () => push(context, ComoFuncionaHomePage())),
        ),
        CardFeature(
          label: 'Ultimas\nNotícias',
          prefix: Symbols.newsmode,
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () => push(context, NoticiasHomePage())),
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
    return AppScaffold(
      onWillPop: () async {
        push(context, ExitBanner());
        return false;
      },
      child: StreamOut<ConsultaPagamentosModel>(
        loading: const BackgroundPage(),
        stream: consultaPagamentoController.consultaPagamentoStream.listen,
        child: (_, consultaPagamento) => body(context, consultaPagamento),
      ),
    );
  }

  Widget body(_, ConsultaPagamentosModel consultaPagamentos) {
    return AppListView(
      children: [
        consultaPagamentos.hasPagamentoSalvo
            ? _headerInfoPagamento(_, consultaPagamentos)
            : _header(),
        const AppTitle('Veja mais opções'),
        const H(24),
        const BannerWidget(),
        const H(16),
        CardFeatures(cardItens)
      ],
    );
  }

  Header _header() {
    return Header.text(
      'Conheça o Novo Bolsa Família',
      'Saiba tudo sobre o Novo Bolsa Família e consulte a disponibilidade do seu benefício.',
      top: HeaderTop(
        leading: AppIcon.share(
            onTap: () => Share.share(
                'https://play.google.com/store/apps/details?id=com.ldcapps.svr')),
      ),
      buttons: [
        AppButton(
            label: 'CONSULTAR BOLSA FAMÍLIA',
            onTap: () => push(context, ConsultaPagamentosHomePage())),
      ],
    );
  }

  Header _headerInfoPagamento(_, ConsultaPagamentosModel consultaPagamentos) {
    return Header(
      top: HeaderTop(
        leading: const AppIcon.person(),
        action: AppIcon.share(
            onTap: isProcessing
                ? null
                : () async {
                    setState(() => isProcessing = true);
                    await Share.share(
                        'https://play.google.com/store/apps/details?id=com.ldcapps.svr');
                    await Future.delayed(const Duration(milliseconds: 500));
                    setState(() => isProcessing = false);
                  }),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, ${consultaPagamentos.bolsaFamilia!.name.split(' ').first}',
              style: const TextStyle(color: AppColors.surfaceContainerLowest)
                  .titleMedium,
            ),
            Text(
              'Benefício Ativo',
              style: const TextStyle(color: AppColors.surfaceContainerLowest)
                  .bodySmall,
            ),
          ],
        ),
      ),
      buttons: [
        AppButton.ad(
            label: 'PRÓXIMO PAGAMENTO',
            onTap: () => AdManager.showIntersticial(context,
                onDispose: () => push(context, ExtratoPage()))),
      ],
      child: Row(
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
          HeaderCard.action(
            label: 'Final do\nNIS',
            title: consultaPagamentos.bolsaFamilia!.nis.characters.last,
            icon: Icons.password,
            action: AppIcon.delete(
              onTap: () => showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) => const HomeBottomSheetPage(),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
