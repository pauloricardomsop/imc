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
import 'package:svr/app/modules/query_deceased/topics/query_deceased_documents_page.dart';
import 'package:svr/app/modules/query_deceased/topics/query_deceased_terms_page.dart';
import 'package:svr/app/modules/query_deceased/topics/query_deceased_values_page.dart';

class QueryDeceasedAccessSystemPage extends JourneyStatefulWidget {
  const QueryDeceasedAccessSystemPage({Key? key})
      : super(key: key, name: 'QueryDeceasedAccessSystemPage');

  @override
  State<QueryDeceasedAccessSystemPage> createState() => QueryDeceasedAccessSystemPageState();
}

class QueryDeceasedAccessSystemPageState extends State<QueryDeceasedAccessSystemPage> {
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
                'Caso haja valores, vai constar a informação "O CPF pesquisado tem valores a receber". E será preciso clicar em "Acessar o SVR" na parte inferior da página;',
            image: const AppImage(
              url:
                  'https://ldcapps.com/wp-content/uploads/2023/04/Como-acessar-o-sistema-do-SVR-1.png',
              height: 200,
            )),
        CheckListModel(
            icon: Icons.arrow_forward,
            label:
                'Na sequência, será preciso se logar na conta gov.br - é preciso ter nível de acesso ouro ou prata (veja como obter). No gov.br devem ser informados o CPF e a senha - cadastrada no sistema - do herdeiro, inventariante, testamentário ou representante legal. Não coloque os dados do falecido;',
            image: const AppImage(
              url:
                  'https://ldcapps.com/wp-content/uploads/2023/04/Como-acessar-o-sistema-do-SVR-2.png',
              height: 200,
            )),
        CheckListModel(
            icon: Icons.arrow_forward,
            label:
                'Na próxima janela, o sistema vai dar duas opções: "Meus valores a receber" e "Valores para pessoas falecidas". Vá na segunda opção e clique em "Acessar";',
            image: const AppImage(
              url:
                  'https://ldcapps.com/wp-content/uploads/2023/04/Como-acessar-o-sistema-do-SVR-3.png',
              height: 200,
            )),
        CheckListModel(
            icon: Icons.arrow_forward,
            label:
                'Agora será preciso informar novamente o CPF e a data de nascimento do falecido. Na sequência, clique em "Consultar";',
            image: const AppImage(
              url:
                  'https://ldcapps.com/wp-content/uploads/2023/04/Como-acessar-o-sistema-do-SVR-4.png',
              height: 200,
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      active: AdController.adConfig.banner.active,
      behavior: ['${widget.name}1', '${widget.name}2'],
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
                onTap: () => push(context, const QueryDeceasedTermsPage()),
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
                    title: 'Como acessar o sistema do SVR',
                    desc:
                        'Se a pessoa falecida possuir alguma valor a receber, você poderá acessar o sistema do SVR. Veja abaixo o passo a passo de como entrar no sistema.',
                  ),
                  const H(16),
                  CheckList(checkList),
                  const H(16),
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
