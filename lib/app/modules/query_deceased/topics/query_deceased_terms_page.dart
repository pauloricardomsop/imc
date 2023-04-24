import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_image.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/button_icon.dart';
import 'package:svr/app/core/components/card_sm.dart';
import 'package:svr/app/core/components/exit_banner.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/query_deceased/topics/query_deceased_documents_page.dart';
import 'package:svr/app/modules/query_deceased/topics/query_deceased_values_page.dart';

class QueryDeceasedTermsPage extends JourneyStatefulWidget {
  const QueryDeceasedTermsPage({Key? key}) : super(key: key, name: 'QueryDeceasedTermsPage');

  @override
  State<QueryDeceasedTermsPage> createState() => QueryDeceasedTermsPageState();
}

class QueryDeceasedTermsPageState extends State<QueryDeceasedTermsPage> {
  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    super.initState();
  }

  List<CardSm> get itens => [
        CardSm(
          title: 'Confira os valores a receber.',
          subtitle: 'Veja as faixas de valores a receber por cada instituição financeira.',
          onTap: () => push(context, const QueryDeceasedValuesPage()),
        ),
        CardSm(
          title: 'Documentos para resgatar junto as instituições.',
          subtitle:
              'Veja quais documentos são necessários e entenda o processo para resgatar dinheiro de falecidos.',
          onTap: () => push(context, const QueryDeceasedDocumentsPage()),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      active: AdController.adConfig.banner.active,
      behavior: [widget.name],
      bottom: _inFoorteCta(),
      child: body(context),
    );
  }

  Widget body(_) {
    return Stack(
      children: [
        AppListView(
          padding: EdgeInsets.zero,
          children: [
            BackHeader(
              button: ButtonIconSmall(
                onTap: () => push(context, const QueryDeceasedValuesPage()),
                icon: Icons.arrow_forward_ios_outlined,
                label: 'Próximo',
                invert: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBannerAd(AdBannerStorage.get(widget.name)),
                  const H(16),
                  const HeaderHero(
                    title: 'Saiba como concordar com os termos de responsabilidade.',
                    desc:
                        'No próximo passo, é necessário concordar com um "Termo de Responsabilidade de acesso a dados de Terceiro". É preciso clicar na caixa ao lado esquerdo de "Aceito o termo de responsabilidade" e, depois, clicar no canto direito em "Confirmar". Não é possível passar para a próxima etapa sem concordar com o termo;',
                  ),
                  const H(16),
                  const AppImage(
                      url:
                          'https://ldcapps.com/wp-content/uploads/2023/04/Saiba-como-concordar-com-os-termos-de-responsabilidade.png'),
                  const H(32),
                  Text(
                    'Veja mais',
                    style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
                  ),
                  ...itens
                ],
              ),
            ),
            const H(160),
          ],
        ),
      ],
    );
  }

  InFooterCta _inFoorteCta() {
    return InFooterCta(
      onTap: () => AdController.showRewardedIntersticialTransitionAd(
          onComplete: () => push(
              context,
              ExitBanner(
                widget.name,
                title: 'Você será encaminhado para um site oficial do governo.',
                url: 'https://valoresareceber.bcb.gov.br/publico',
                buttonLabel: 'Ir para site externo',
                buttonSubLabel: 'Você será redirecionado para o site oficial do Banco Central:  ',
                buttonSubLabelBold: 'valoresareceber.bcb.gov.br',
              ))),
      label: 'Consultar Valores a Receber',
      invert: true,
      subtitle: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
              text: 'Você será redirecionado para o site oficial do Banco Central:  ',
              style: AppTheme.text.normal.sm(const Color(0xFF474747))),
          TextSpan(
              text: 'valoresareceber.bcb.gov.br',
              style: AppTheme.text.normal
                  .sm(const Color(0xFF474747))
                  .copyWith(fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}
