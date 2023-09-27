import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_nis/consulta_nis_controller.dart';
import 'package:svr/app/modules/consulta_nis/consulta_nis_model.dart';
import 'package:svr/app/modules/consulta_nis/ui/topics/consulta_nis_cartao_cidadao_page.dart';
import 'package:svr/app/modules/consulta_nis/ui/topics/consulta_nis_site_cnis_page.dart';
import 'package:svr/app/modules/consulta_nis/ui/topics/consulta_nis_site_meu_inss.dart';
import 'package:svr/app/modules/consulta_nis/ui/topics/consulta_nis_telefone_page.dart';
import 'package:svr/app/modules/home/home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConsultaNisNaoEncontradoPage extends AdStatefulWidget {
  ConsultaNisNaoEncontradoPage({Key? key})
      : super(key: key, name: 'ConsultaPagamentosErrorPage');

  @override
  State<ConsultaNisNaoEncontradoPage> createState() =>
      _ConsultaPagamentosIndisponivelPageState();
}

class _ConsultaPagamentosIndisponivelPageState
    extends State<ConsultaNisNaoEncontradoPage> {
  final ConsultaNisController _controller = ConsultaNisController();

  List<CardFeature> get cardItens => [
        CardFeature(
          label: 'Consultar NIS pelo\nsite CNIS',
          prefix: Symbols.public,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, ConsultaNisSiteCnisPage())),
        ),
        CardFeature(
          label: 'Consultar NIS pelo\nsite Meu INSS',
          prefix: Symbols.public,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, ConsultaNisSiteMeuInssPage())),
        ),
        CardFeature(
          label: 'Consultar NIS pelo\nCartão Cidadão',
          prefix: Symbols.credit_card,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, ConsultaNisCartaoCidadaoPage())),
        ),
        CardFeature(
          label: 'Consultar NIS por\nTelefone',
          prefix: Symbols.call_quality,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, ConsultaNisTelefonePage())),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: StreamOut<ConsultaNisModel>(
        stream: _controller.consultaNistream.listen,
        child: (_, model) => body(context, model),
      ),
    );
  }

  Widget body(_, ConsultaNisModel model) {
    return AppListView(
      padding: EdgeInsets.zero,
      children: [
        HeaderTop(
          leading: AppIcon.home(
              iconColor: const Color(0xFFFEE2E2),
              backgroundColor: const Color(0xFF991B1B),
              onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false,
                  )),
          backgroundColor: const Color(0xFFDC2626),
          child: Text(
            'Beneficiário não encontrado.',
            style: const TextStyle(color: Color(0xFFFEF2F2)).titleSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const AppImage(
                url: 'assets/images/bro.svg',
                isSVG: true,
                fit: BoxFit.contain,
              ),
              const H(24),
              Text(
                'CPF: ${model.cpf.text}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.onSurface).titleLarge,
              ),
              const H(8),
              Text(
                'Não encontramos beneficiários com o NIS informado no Portal da Transparência. Verifique se o NIS informado está correto e tente novamente. ',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.onSurface).bodyMedium,
              ),
              const H(32),
              AppButton(
                label: 'TENTAR NOVAMENTE',
                onTap: () => Navigator.pop(context),
              ),
              const H(24),
              const AppTitle('Outras opções'),
              const H(24),
              const BannerWidget(),
              const H(24),
              CardFeatures(cardItens)
            ],
          ),
        )
      ],
    );
  }
}
