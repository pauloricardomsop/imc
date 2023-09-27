import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConsultaNisTelefonePage extends AdStatefulWidget {
  ConsultaNisTelefonePage({Key? key}) : super(key: key, name: 'ConsultaNisTelefonePage');

  @override
  State<ConsultaNisTelefonePage> createState() => _ConsultaNisTelefonePage();
}

class _ConsultaNisTelefonePage extends State<ConsultaNisTelefonePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bottom: Footer(
          AppButton(
            onTap: () => AdUtils.loadUrl("tel://135"),
            label: 'LIGAR PARA INSS',
            icon: Symbols.open_in_new,
          ),
        ),
        child: body(context));
  }

  Widget body(_) {
    return const AppListView(
      children: [
        Header(
          backgroundColor: AppColors.white,
          top: HeaderTop(
            backgroundColor: AppColors.white,
            leading: AppIcon.back(
              backgroundColor: AppColors.surfaceContainer,
              iconColor: AppColors.onSurface,
            ),
          ),
          title: 'Consultando NIS pelo telefone do INSS',
          desc:
              'É possível consultar o número do seu NIS ligando para a central de atendimento do INSS. O atendimento é realizado de Segunda à Sábado de 7h às 22h horário de Brasília. Para ligar basta clicar no botão fixo no inferior da tela.',
        ),
        BannerWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: AppImage(url: 'assets/images/image7.png', isSVG: false, fit: BoxFit.contain),
        ),
        AppDesc('A numeração que está impressa é a mesma que compõe o número do seu NIS.')
      ],
    );
  }
}
