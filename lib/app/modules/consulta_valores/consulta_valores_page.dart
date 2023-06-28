import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/ad_icon.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_image.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/check_list.dart';
import 'package:svr/app/core/components/exit_banner.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/components/rate_app.dart';
import 'package:svr/app/core/components/web_view_page.dart';
import 'package:svr/app/core/models/accordeon_model.dart';
import 'package:svr/app/core/models/check_list_model.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class ConsultaValoresPage extends JourneyStatefulWidget {
  const ConsultaValoresPage({Key? key}) : super(key: key, name: 'ConsultaValoresPage');

  @override
  State<ConsultaValoresPage> createState() => ConsultaValoresPageState();
}

class ConsultaValoresPageState extends State<ConsultaValoresPage> {
  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get('${widget.name}1'),
    );
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get('${widget.name}2'),
    );
    super.initState();
  }

  final List<CheckListModel> _checkList = [
    CheckListModel(
      icon: Icons.arrow_forward,
      label:
          'Nesta segunda fase somente é possível solicitar o resgate do valor através de uma chave PIX.',
    ),
    CheckListModel(
      icon: Icons.arrow_forward,
      label:
          'No novo sistema do SVR,  você não precisa mais esperar para solicitar o resgate do valor.',
    ),
    CheckListModel(
      icon: Icons.arrow_forward,
      label:
          'Agora é possível emitir um comprovante informando seus valores a receber e compartilhar este comprovante até mesmo por WhatsApp.',
    ),
    CheckListModel(
      icon: Icons.arrow_forward,
      label:
          'O resgate para pessoas falecidas agora está disponível. Para mais informações, acesse a página principal do App, a opção valores de falecidos.',
    ),
    CheckListModel(
      icon: Icons.arrow_forward,
      label:
          'É possível nesta segunda fase ter disponível novos valores, pois foram incluídas novas instituições financeiras.',
    ),
    CheckListModel(
      icon: Icons.arrow_forward,
      label: 'O novo SVR também consulta valores relativos a contas conjuntas.',
    ),
  ];

  final List<AccordeonModel> _questions = [
    AccordeonModel(
      title: 'Qual o prazo para receber o dinheiro esquecido?',
      desc:
          'O prazo para receber depende da forma de solicitação. Se for solicitado no sistema com chave PIX o valor será recebido em até 12 dias úteis. Se for solicitado diretamente em contato com a instituição, ou pelo sistema sem PIX, o prazo pode passar de 12 dias úteis.',
    ),
    AccordeonModel(
      title: 'Quais são as formas de receber o dinheiro esquecido?',
      desc:
          'O dinheiro esquecido pode ser solicitado pelo SRV ou direto com a instituição financeira ou banco, e pode ser enviado ao cliente por PIX, TED ou DOC.',
    ),
    AccordeonModel(
      title: 'Como saber se tenho valores a receber do Banco Central?',
      desc:
          'Basta entrar no site Valores a Receber, do Banco Central, inserir o número do seu CPF, data de nascimento e conferir se tem direito.',
    ),
    AccordeonModel(
      title: 'Quais as recomendações para evitar golpes no SVR?',
      desc:
          'O Banco Central recomenda que as pessoas desconfiem de toda informação recebida por WhatsApp e não acessem nenhum link nas mensagens, pois podem roubar senhas, instalar vírus e programas maliciosos. A única fonte oficial de informações sobre o SVR é o site oficial do Banco Central.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: ['${widget.name}1', '${widget.name}2'],
        bottom: _inFooterCta(),
        child: body(context));
  }

  Widget body(_) {
    return Stack(
      children: [
        AppListView(
          padding: EdgeInsets.zero,
          children: [
            const BackHeader(
                // button: ButtonIconSmall(
                //   onTap: () {},
                //   icon: Icons.arrow_forward_ios_outlined,
                //   label: 'Próximo',
                //   invert: true,
                // ),
                ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBannerAd(AdBannerStorage.get('${widget.name}1')),
                  const H(16),
                  const HeaderHero(
                    title: 'Passo a passo para consultar e resgatar valores a receber.',
                    desc:
                        'O sistema de valores a receber começou a sua segunda fase em 7 de Março de 2023.\n\nNesta segunda fase, é possível consultar novos valores, para você ou para falecidos.\n\nO SVR está com um novo sistema de consulta. Veja o passo a passo de como consultar e dicas importantes.',
                  ),
                  const H(24),
                  Text(
                    'Como consultar valores a receber?',
                    style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
                  ),
                  const H(8),
                  Text(
                    'Para consultar valores a receber, tanto para você como para falecidos, basta acessar o site: valoresareceber.bcb.gov.br e o CPF e data de nascimento.\n\nNo caso de empresa, informar o CNPJ e a data de abertura da empresa.',
                    style: AppTheme.text.normal.base(const Color(0xFF474747)),
                  ),
                  const H(16),
                  const AppImage(
                      url:
                          'https://ldcapps.com/wp-content/uploads/2023/04/Como-acessar-a-consulta-do-SVR.png',
                      height: 600),
                  const H(16),
                  AppBannerAd(AdBannerStorage.get('${widget.name}2')),
                  const H(16),
                  const AppRate(),
                  const H(16),
                  Text(
                    '6 Novidades importantes sobre o SVR.',
                    style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
                  ),
                  const H(16),
                  CheckList(_checkList),
                  const H(160),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  InFooterCta _inFooterCta() {
    return InFooterCta(
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
      label: 'CONSULTAR VALORES',
      invert: true,
      icon: const AdIcon(),
    );
  }
}