import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_card_purple.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/app_video.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/button_icon.dart';
import 'package:svr/app/core/components/card_sm.dart';
import 'package:svr/app/core/components/exit_banner.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/query_deceased/topics/query_deceased_access_query_page.dart';
import 'package:svr/app/modules/query_deceased/topics/query_deceased_access_sistem_page.dart';
import 'package:svr/app/modules/query_deceased/topics/query_deceased_documents_page.dart';
import 'package:svr/app/modules/query_deceased/topics/query_deceased_terms_page.dart';
import 'package:svr/app/modules/query_deceased/topics/query_deceased_values_page.dart';

class QueryDeceasedDetailedPage extends JourneyStatefulWidget {
  const QueryDeceasedDetailedPage({Key? key}) : super(key: key, name: 'QueryDeceasedDetailedPage');

  @override
  State<QueryDeceasedDetailedPage> createState() => QueryDeceasedDetailedPageState();
}

class QueryDeceasedDetailedPageState extends State<QueryDeceasedDetailedPage> {
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
          title: 'Acessar a consulta do SVR',
          subtitle:
              'Consulte valores de falecidos com CPF e data de nascimento da pessoa falecida.',
          onTap: () => push(context, const QueryDeceasedAccessQueryPage()),
        ),
        CardSm(
          title: 'Acessar sistema do SVR',
          subtitle: 'Acesse o sistema SVR através de uma conta GOV.BR.',
          onTap: () => push(context, const QueryDeceasedAccessSystemPage()),
        ),
        CardSm(
          title: 'Concorde com os termos de responsabilidade.',
          subtitle: 'Só é possível resgatar o dinheiro, aceitando os termos de responsabilidade.',
          onTap: () => push(context, const QueryDeceasedTermsPage()),
        ),
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
      body: body(context),
    );
  }

  Widget body(_) {
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.zero,
          children: [
            BackHeader(
              button: ButtonIconSmall(
                onTap: () => push(context, const QueryDeceasedAccessQueryPage()),
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
                    title:
                        'Passo a passo para consultar e resgatar valores a receber de falecidos.',
                    desc:
                        'O sistema valores a receber começou a sua segunda faze como uma grande novidade, agora você pode consultar e resgatar valores de pessoas falecidas\n\nVeja passo a passo e dicas importantes de como resgatar valores de pessoas falecidas.',
                  ),
                  const H(24),
                  const AppVideo('rk8T5jzGmZg'),
                  const H(24),
                  const AppCardPurple(
                      'Atenção: O vídeo acima é do canal oficial do Banco Central no Youtube. Nosso app não tem nenhum relacionamento formal com o Banco Centra. Somente facilitamos o acesso a informações baseadas nos sites oficiais.'),
                  const H(32),
                  Text(
                    'Passo a passo de como resgatar valores de pessoas falecidas?',
                    style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
                  ),
                  ...itens
                ],
              ),
            ),
            const H(160),
          ],
        ),
        InFooterCta(
          onTap: () => push(
              context,
              ExitBanner(
                widget.name,
                title: 'Você será encaminhado para um site oficial do governo.',
                url: 'https://valoresareceber.bcb.gov.br/publico',
                buttonLabel: 'Ir para site externo',
                buttonSubLabel: 'Você será redirecionado para o site oficial do Banco Central:  ',
                buttonSubLabelBold: 'valoresareceber.bcb.gov.br',
              )),
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
        )
      ],
    );
  }
}
