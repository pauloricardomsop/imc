import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:svr/app/core/components/exit_banner.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class HomePage extends AdStatefulWidget {
  HomePage({Key? key}) : super(key: key, name: 'HomePage');

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  List<CardFeature> get cardItens => [];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        onWillPop: () async {
          push(context, ExitBanner());
          return false;
        },
        child: body(context));
  }

  Widget body(_) {
    return AppListView(
      children: [
        Header.text(
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
                onTap: () => push(context, Container())),
          ],
        ),
        const AppTitle('Veja mais opções'),
        const H(24),
        const BannerWidget(),
        const H(16),
        CardFeatures(cardItens)
      ],
    );
  }
}
