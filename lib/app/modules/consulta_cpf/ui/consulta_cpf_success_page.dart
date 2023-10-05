import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/client/cpf_captcha/models/cpf_captcha_situacao_model.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_cpf/topics/consulta_cpf_situacao_cadastrais_page.dart';
import 'package:svr/app/modules/consulta_cpf/ui/consulta_cpf_bottomsheet_page.dart';

class ConsultaCPFSuccessPage extends AdStatefulWidget {
  final CPFCaptchaSituacaoModel model;
  ConsultaCPFSuccessPage(this.model, {Key? key})
      : super(key: key, name: 'ConsultaCPFSuccessPage');

  @override
  State<ConsultaCPFSuccessPage> createState() => _ConsultaCPFSuccessPageState();
}

class _ConsultaCPFSuccessPageState extends State<ConsultaCPFSuccessPage> {
  late DateTime now;

  List<CardFeature> get cardHomeItens => [
        CardFeature(
          label: 'Como funciona e\nvalores.',
          prefix: Symbols.attach_money,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, const Text('Como funciona e\nvalores.'))),
        ),
        CardFeature(
          label: 'Consulte suas\ndívidas',
          prefix: Symbols.request_quote,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context,  const Text('Consulte suas\ndívidas'))),
        ),
      ];

  @override
  void initState() {
    now = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: body(context),
    );
  }

  Widget body(_) {
    return AppListView(
      children: [
        _headerInfoPagamento(_),
        AppImage(
          url: widget.model.isSituacaoRegular
              ? 'assets/images/check_circle.svg'
              : 'assets/images/gpp_maybe.svg',
          isSVG: true,
          fit: BoxFit.contain,
          height: 100,
        ),
        const H(30),
        Center(
          child: Text(
            widget.model.isSituacaoRegular
                ? 'Situação Regular'
                : widget.model.situacaoCadastral,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF020617)).titleLarge,
          ),
        ),
        const H(8),
        const Center(
          child: AppDesc(
              'O resultado desta consulta não tem valor\nfiscal ou de crédito.',
              textAlign: TextAlign.center),
        ),
        const H(16),
        AppButton.textButtons(
          label: 'VER DETALHES',
          onTap: () => showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) => ConsultaCPFBottomSheetPage(widget.model, now),
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
          ),
          icon: Symbols.arrow_upward_alt,
          foregroundColor: AppColors.primary,
          backgroundColor: AppColors.surfaceContainerLowest,
          labelColor: AppColors.primary,
        ),
        const Divider(color: AppColors.surfaceContainerHigh),
        const H(24),
        CardFeatures.full([
          CardFeature.full(
            label: 'Entenda a situação\ndo seu CPF',
            onTap: () => AdManager.showRewarded(
                onDispose: () =>
                    push(context, ConsultaCpfAtivoSituacaoCadastraisPage())),
            prefix: Symbols.assured_workload,
            sufix: const AdIcon(
              color: AppColors.surfaceContainerHighest,
            ),
          )
        ]),
        const H(24),
        const SelectYesNo(),
        const H(24),
        const AppTitle('Mais opções'),
        const H(16),
        CardFeatures(cardHomeItens),
      ],
    );
  }

  Header _headerInfoPagamento(_) {
    return Header(
      backgroundColor: AppColors.surfaceContainerLowest,
      top: HeaderTop.light(
        leading: const AppIcon.backLight(),
        child: Text(
          'CPF encontrado.',
          style: const TextStyle(color: AppColors.onSurface).bodyMedium,
        ),
      ),
      child: const BannerWidget(),
    );
  }
}
