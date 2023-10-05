import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class ConsultaCPFDataInvalidaPage extends AdStatefulWidget {
  ConsultaCPFDataInvalidaPage({Key? key})
      : super(key: key, name: 'ConsultaCPFDataInvalidaPage');

  @override
  State<ConsultaCPFDataInvalidaPage> createState() =>
      _ConsultaCPFDataInvalidaPageState();
}

class _ConsultaCPFDataInvalidaPageState extends State<ConsultaCPFDataInvalidaPage> {


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
          url: 'assets/images/dateerror.svg',
          isSVG: true,
          fit: BoxFit.contain,
        ),
        const H(16),
        const Center(
          child: HeaderTitle(
            'Erro na data de\nnascimento',
            color: AppColors.onSurface,
            textAlign: TextAlign.center,
          ),
        ),
        const H(16),
        const HeaderDesc(
          'A data de nascimento informada não corresponde ao CPF.',
          color: AppColors.onSurface,
          textAlign: TextAlign.center,
        ),
        const H(24),
        AppButton(
            label: 'TENTAR NOVAMENTE',
            onTap: () => Navigator.pop(context),
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
