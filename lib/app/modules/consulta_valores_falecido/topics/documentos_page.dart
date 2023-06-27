import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/ad_icon.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/check_list.dart';
import 'package:svr/app/core/components/exit_banner.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/components/web_view_page.dart';
import 'package:svr/app/core/models/check_list_model.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class DocumentosPage extends JourneyStatefulWidget {
  const DocumentosPage({Key? key}) : super(key: key, name: 'DocumentosPage');

  @override
  State<DocumentosPage> createState() => DocumentosPageState();
}

class DocumentosPageState extends State<DocumentosPage> {
  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    super.initState();
  }

  List<CheckListModel> get _checkList1 => [
        CheckListModel(
          icon: Icons.arrow_forward,
          label: 'Certidão de óbito do falecido; ou',
        ),
        CheckListModel(
          icon: Icons.arrow_forward,
          label: 'Comprovante de Situação Cadastral no CPF; ou',
        ),
        CheckListModel(
          icon: Icons.arrow_forward,
          label:
              'Outro documento emitido por cartório ou pelo Poder Judiciário, como, por exemplo: decisão, certidão ou escritura pública.',
        ),
      ];

  List<CheckListModel> get _checkList2 => [
        CheckListModel(
          icon: Icons.arrow_forward,
          label: 'Decisão judicial que autorizou a inventariança;',
        ),
        CheckListModel(
          icon: Icons.arrow_forward,
          label: 'Termo de compromisso para desempenhar a função, assinado pelo inventariante;',
        ),
        CheckListModel(
          icon: Icons.arrow_forward,
          label:
              'Certidão do Juízo do Inventário que afirme que o inventariante não foi afastado da função.',
        ),
      ];

  List<CheckListModel> get _checkList3 => [
        CheckListModel(
          icon: Icons.arrow_forward,
          label: 'Procuração específica de outorga de poderes de herdeiro/inventariante;',
        ),
        CheckListModel(
          icon: Icons.arrow_forward,
          label:
              'Documentos que comprovem a condição de herdeiro ou inventariante do outorgante e a identidade do procurador.',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: [widget.name],
        bottom: _inFooterCta(),
        child: body(context));
  }

  Widget body(_) {
    return AppListView(
      padding: EdgeInsets.zero,
      children: [
        const BackHeader(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(16),
              const HeaderHero(
                title: 'Quais documentos são necessários para consultar valores de falecidos?',
                desc:
                    'No sistema, o Banco Central explica que a instituição que deve devolver o valor é responsável por definir os documentos que você deve apresentar para solicitar o dinheiro da pessoa falecida. Por conta disso, é preciso verificar com a empresa quais são os documentos necessários. \n\nAlguns desses documentos geralmente são:',
              ),
              const H(16),
              CheckList(_checkList1),
              const H(16),
              Text(
                'No caso de herdeiro legítimo: Documento que comprove o parentesco entre o herdeiro interessado na devolução e o falecido (documento de identificação, certidão de nascimento, casamento, etc.).',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
              const H(16),
              Text(
                'No caso de herdeiro testamentário: Decisão judicial que determine o registro, arquivamento e cumprimento do testamento.',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
              const H(16),
              Text(
                'No caso de inventariante extrajudicial: Certidão ou escritura pública, expedida por cartório de notas ou por ofício de justiça, que comprove o processamento do inventário e a sua indicação como inventariante.',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
              const H(32),
              Text(
                'No caso de inventariante judicial',
                style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
              ),
              const H(16),
              CheckList(_checkList2),
              Text(
                'No caso de procurador',
                style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
              ),
              const H(16),
              CheckList(_checkList3),
              const H(16),
            ],
          ),
        ),
      ],
    );
  }

  InFooterCta _inFooterCta() {
    return InFooterCta(
      label: 'CONSULTAR VALORES',
      onTap: () => push(
          context,
          ExitBanner(
            widget.name,
            title: 'Consulta de valores a receber do BACEN',
            buttonLabel: 'CONSULTAR VALORES',
            buttonSubLabel: 'Após o anúncio você terá acesso ao formulário de valores a receber:  ',
            buttonSubLabelBold: 'https://valoresareceber.bcb.gov.br/publico',
            onClick: () => AdController.showRewardTransitionAd(
          onComplete: () =>
              push(context, const WebViewPage('https://valoresareceber.bcb.gov.br/publico'))),
          )),
      invert: true,
      icon: const AdIcon(),
    );
  }
}
