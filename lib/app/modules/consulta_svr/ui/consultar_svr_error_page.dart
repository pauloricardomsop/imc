import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_svr/consultar_svr_controller.dart';

class ConsultarSVRServicoIndisponivelPage extends AdStatefulWidget {
  ConsultarSVRServicoIndisponivelPage({
    Key? key,
  }) : super(key: key, name: 'ConsultarSVRServicoIndisponivelPage');

  @override
  State<ConsultarSVRServicoIndisponivelPage> createState() =>
      ConsultarSVRServicoIndisponivelPageState();
}

class ConsultarSVRServicoIndisponivelPageState
    extends State<ConsultarSVRServicoIndisponivelPage> {
  final ConsultarSVRController _controller = ConsultarSVRController();

  List<CardFeature> get gridItens => [
        CardFeature(
          label: 'Serviços do Banco Central',
          prefix: Symbols.account_balance,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going, onDispose: () => push(context, Container())),
        ),
        CardFeature(
          label: 'Estatísticas\ndo SVR',
          prefix: Symbols.monitoring,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going, onDispose: () => push(context, Container())),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: AppColors.surfaceContainerLowest,
      backgroundColor: AppColors.surfaceContainerLowest,
      child: Column(
        children: [
          Header.light(
            top: HeaderTop.light(
              backgroundColor: AppColors.surfaceContainerLowest,
              leading: AppIcon.exit(onTap: () => AdManager.showIntersticial(context, flow: AdFlow.returning)),
              child: Text('O Banco Central não está\nrespondendo, volte mais tarde.', style: const TextStyle(color: AppColors.onSurface).bodyMedium),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const Expanded(
                    child: AppImage(
                      url: 'assets/images/pana.svg',
                      fit: BoxFit.contain,
                      isSVG: true,
                    ),
                  ),
                  const H(24),
                  const Center(
                    child: HeaderTitle(
                      'Serviço\nIndisponível',
                      textAlign: TextAlign.center,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const H(12),
                  const Center(
                    child: AppDesc(
                      'Os serviços do Banco Central estão temporariamente indisponíveis.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const H(24),
                  AppButton(
                    label: 'TENTAR NOVAMENTE',
                    icon: Symbols.restart_alt,
                    onTap: () => _controller.onClickTentarNovamente(context),
                  ),
                  const H(16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
