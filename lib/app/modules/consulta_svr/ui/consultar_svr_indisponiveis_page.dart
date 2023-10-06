import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_svr/consultar_svr_controller.dart';
import 'package:svr/app/modules/estatisticas/ui/estatisticas_home_page.dart';
import 'package:svr/app/modules/home/home_page.dart';

class ConsultarSVRNaoEncontradoPage extends AdStatefulWidget {
  ConsultarSVRNaoEncontradoPage({
    Key? key,
  }) : super(key: key, name: 'ConsultarSVRNaoEncontradoPage');

  @override
  State<ConsultarSVRNaoEncontradoPage> createState() =>
      ConsultarSVRNaoEncontradoPageState();
}

class ConsultarSVRNaoEncontradoPageState
    extends State<ConsultarSVRNaoEncontradoPage> {
  final ConsultarSVRController _controller = ConsultarSVRController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: AppColors.surfaceContainerLowest,
      child: AppListView(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AppIcon.exit(
              onTap: () => Navigator.pop(context),
            ),
          ),
          const H(16),
          const BannerWidget(),
          const H(20),
          Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFDC2625),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Symbols.exclamation,
                size: 32,
                weight: 700,
                color: Color(0xFFECFEF6),
              ),
            ),
          ),
          const H(24),
          const Center(
              child: AppTitle(
            'Não foram encontrados\nvalores a receber para os\ndados informados:',
            textAlign: TextAlign.center,
          )),
          const H(24),
          Row(
            children: [
              HeaderCard.text(
                label: 'CPF do\nTitular',
                icon: Symbols.password,
                title: _controller.consulta.identifier.text,
              ),
              const W(8),
              HeaderCard.text(
                label: 'Data de\nNascimento',
                icon: Symbols.event,
                title: _controller.consulta.date.text,
              )
            ],
          ),
          const H(24),
          AppButton(
              label: 'PRÓXIMAS DIVULGAÇÕES',
              icon: Icons.calendar_month,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false);
                push(context, EstatisticasHomePage());
              }),
          const H(12),
          AppButton(
              label: 'NOVA CONSULTA',
              backgroundColor: const Color(0xFFEFF6FF),
              borderColor: const Color(0xFF94C4FD),
              foregroundColor: const Color(0xFF172554),
              onTap: () => AdManager.showIntersticial(context, flow: AdFlow.going, onDispose: () => pops(context, 2))),
          const H(24),
          const CardAlert(
            icon: AppIcon.info(
              backgroundColor: Color(0xFFFECACA),
              iconColor: Color(0xFF450B0A),
            ),
            label:
                'Verifique se o CPF e a data de nascimento estão corretos. Se estiverem errados, refaça a consulta.',
            backgroundColor: Color(0xFFFFE2E1),
            borderColor: Color(0xFFFECACA),
            textColor: Color(0xFF450B0A),
          ),
          const H(24),
          const AppDesc(
            'Mensalmente são divulgados novos valores a receber. Verifique o calendário e confira',
            textAlign: TextAlign.center,
          ),
          const H(24),
          const RateApp()
        ],
      ),
    );
  }
}
