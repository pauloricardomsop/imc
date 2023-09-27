import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/calculadora_renda/calculadora_renda_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class BeneficiosHomePage extends AdStatefulWidget {
  BeneficiosHomePage({Key? key}) : super(key: key, name: 'BeneficiosHomePage');

  @override
  State<BeneficiosHomePage> createState() => _BeneficiosHomePageState();
}

class _BeneficiosHomePageState extends State<BeneficiosHomePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: body(context),
    );
  }

  Widget body(_) {
    return AppListView(
      children: [
        Header(
          top: const HeaderTop(),
          title: 'Encontre o benefício ideal para você.',
          desc: 'Listamos os principais benefícios oferecidos pelo governo.',
          buttons: [
            AppButton(
              onTap: () => AdManager.showIntersticial(context,
                  onDispose: () => push(context, CalculadoraRendaPage())),
              label: 'ACESSAR CALCULADORA',
              icon: const AdIcon(),
            ),
          ],
        ),
        const AppTitle('Veja mais opções.'),
        const H(16),
        const BannerWidget(),
        const H(16)
      ],
    );
  }
}
