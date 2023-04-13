import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_image.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/button_icon.dart';
import 'package:svr/app/core/components/card_sm.dart';
import 'package:svr/app/core/components/check_list.dart';
import 'package:svr/app/core/components/exit_banner.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/models/check_list_model.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/query_deceased/topics/query_deceased_access_sistem_page.dart';
import 'package:svr/app/modules/query_deceased/topics/query_deceased_documents_page.dart';
import 'package:svr/app/modules/query_deceased/topics/query_deceased_terms_page.dart';
import 'package:svr/app/modules/query_deceased/topics/query_deceased_values_page.dart';

class QueryDeceasedAccessQueryPage extends JourneyStatefulWidget {
  const QueryDeceasedAccessQueryPage({Key? key})
      : super(key: key, name: 'QueryDeceasedAccessQueryPage');

  @override
  State<QueryDeceasedAccessQueryPage> createState() => QueryDeceasedAccessQueryPageState();
}

class QueryDeceasedAccessQueryPageState extends State<QueryDeceasedAccessQueryPage> {
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

  List<CheckListModel> get checkList => [
        CheckListModel(
            icon: Icons.arrow_forward,
            label:
                'Acesse o site oficial do Banco Central pelo link valoresareceber.bcb.gov.br ou clicando no botão abaixo.'),
        CheckListModel(
            icon: Icons.arrow_forward,
            label: 'Em seguida, digite o CPF e a data de nascimento da pessoa falecida;'),
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
                onTap: () => push(context, const QueryDeceasedAccessSystemPage()),
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
                    title: 'Como acessar a consulta do SVR',
                    desc:
                        'Para acessar a consulta do Sistema de Valores a Receber, disponibilizamos o seguinte passo a passo.',
                  ),
                  const H(16),
                  CheckList(checkList),
                  const H(16),
                  const AppImage(
                      url:
                          'https://ldcapps.com/wp-content/uploads/2023/04/Como-acessar-a-consulta-do-SVR.png',
                      height: 550),
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
