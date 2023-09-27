import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_nis/ui/consulta_nis_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConsultaNisCartaoCidadaoPage extends AdStatefulWidget {
  ConsultaNisCartaoCidadaoPage({Key? key})
      : super(key: key, name: 'ConsultaNisCartaoCidadaoPage');

  @override
  State<ConsultaNisCartaoCidadaoPage> createState() =>
      _ConsultaNisCartaoCidadaoPage();
}

class _ConsultaNisCartaoCidadaoPage
    extends State<ConsultaNisCartaoCidadaoPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bottom: Footer(
          AppButton(
            onTap: () => AdManager.showIntersticial(context,
                onDispose: () => push(context, ConsultaNisHomePage())),
            label: 'CONSULTAR NIS COM CPF',
            icon: Symbols.trending_flat,
          ),
        ),
        child: const AppListView(
          children: [
            Header.light(),
            HeaderTitle(
              'Consultando NIS através do Cartão Cidadão',
              color: Color(0xFF020617),
            ),
            H(16),
            HeaderDesc(
              'Se você tem um Cartão Cidadão por perto, basta olhar pra ele, você verá a numeração destacada na parte frontal do cartão.',
              color: Color(0xFF020617),
            ),
            H(16),
            BannerWidget(),
            H(16),
            AppImage(
                url: 'assets/images/image7.png',
                isSVG: false,
                fit: BoxFit.contain),
            AppDesc(
                'A numeração que está impressa é a mesma que compõe o número do seu NIS.')
          ],
        ));
  }
}
