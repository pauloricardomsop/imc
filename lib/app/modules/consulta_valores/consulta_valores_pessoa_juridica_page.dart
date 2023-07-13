import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_image.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/components/web_view_page.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class ConsultaValoresPessoaJuridicaPage extends JourneyStatefulWidget {
  const ConsultaValoresPessoaJuridicaPage({Key? key})
      : super(key: key, name: 'ConsultaValoresPessoaJuridicaPage');

  @override
  State<ConsultaValoresPessoaJuridicaPage> createState() => ConsultaValoresPessoaTipoPageState();
}

class ConsultaValoresPessoaTipoPageState extends State<ConsultaValoresPessoaJuridicaPage> {
  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: [widget.name],
        bottom: InFooterCta(
          onTap: () => push(context, const WebViewPage('https://valoresareceber.bcb.gov.br/publico')),
          label: 'CONSULTAR VALORES',
          invert: true,
          icon: Icons.arrow_forward,
        ),
        child: body(context));
  }

  Widget body(_) {
    return Stack(
      children: [
        AppListView(
          padding: EdgeInsets.zero,
          children: [
            const BackHeader(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBannerAd(AdBannerStorage.get(widget.name)),
                  const H(24),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFE3E2E2), borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Text(
                      'Pessoa Jurídica',
                      style: AppTheme.text.normal.sm(const Color(0xFF1B1C1C)),
                    ),
                  ),
                  const H(8),
                  const HeaderHero(
                    title: 'Como consultar valores a receber?',
                    desc:
                        'Inicie sua consulta acessando o site valoresareceber.bcb.gov.br logo após, você verá um formulário de consulta pública. Para consultar valores esquecidos no banco, você deverá inserir o tipo de documento que será consultado, seguido do CNPJ e data de abertura da empresa.\n\nApós realizar este processo, basta clicar em consultar.',
                  ),
                  const H(16),
                  const AppImage(
                      url:
                          'https://t4.ftcdn.net/jpg/04/33/46/65/360_F_433466592_JpXOCCvbV3kMKTWo3jZKhGBnqEafnmfw.jpg'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
