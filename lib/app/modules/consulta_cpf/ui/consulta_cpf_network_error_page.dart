import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/modules/consulta_cpf/consulta_cpf_controller.dart';

class ConsultaCPFNetworkErrorPage extends AdStatefulWidget {
  ConsultaCPFNetworkErrorPage({Key? key})
      : super(key: key, name: 'ConsultaCPFNetworkErrorPage');

  @override
  State<ConsultaCPFNetworkErrorPage> createState() =>
      _ConsultaCPFNetworkHomePageState();
}

class _ConsultaCPFNetworkHomePageState
    extends State<ConsultaCPFNetworkErrorPage> {
  final ConsultaCPFController _controller = ConsultaCPFController();
  @override
  void initState() {
    // _controller.cpfAdapter.getCaptcha();
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
        const AppImage(
          url: 'assets/images/pana.svg',
          isSVG: true,
          fit: BoxFit.contain,
        ),
        const H(16),
        const Center(
          child: HeaderTitle(
            'Serviço\nIndisponível',
            color: AppColors.onSurface,
            textAlign: TextAlign.center,
          ),
        ),
        const H(16),
        const HeaderDesc(
          'Os serviços da Receita Federal estão temporariamente indisponíveis.',
          color: AppColors.onSurface,
          textAlign: TextAlign.center,
        ),
        const H(24),
        AppButton(
          label: 'TENTAR NOVAMENTE',
          onTap: () => ConsultaCPFController().onClickProximo(_),
          icon: const AdIcon(),
        )
      ],
    );
  }

  Header _headerInfoPagamento(_) {
    return const Header(
      backgroundColor: AppColors.surfaceContainerLowest,
      top: HeaderTop.light(
          leading: AppIcon.exit(
        iconColor: AppColors.onSurface,
        backgroundColor: AppColors.surfaceContainer,
      )),
      child: BannerWidget(),
    );
  }
}
