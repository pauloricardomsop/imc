import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_accordeon.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/check_list.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/components/redirect_banner.dart';
import 'package:svr/app/core/models/accordeon_model.dart';
import 'package:svr/app/core/models/check_list_model.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class RegistratoChavePixPage extends JourneyStatefulWidget {
  const RegistratoChavePixPage({Key? key})
      : super(key: key, name: 'RegistratoChavePixPage');

  @override
  State<RegistratoChavePixPage> createState() => RegistratoChavePixPageState();
}

class RegistratoChavePixPageState extends State<RegistratoChavePixPage> {
  List<CheckListModel> get _checklist => [
        CheckListModel(
            icon: Icons.done,
            label: 'Consultar detalhes de suas chaves Pix cadastradas; e'),
        CheckListModel(
            icon: Icons.done,
            label: 'Conferir se existe dívida que não contratou;'),
      ];
  List<AccordeonModel> get _accordeonlist => [
        AccordeonModel(
            title: 'Como consultar o relatório',
            desc:
                'Consulte seu Relatório de Chaves Pix no sistema Registrato, usando sua Conta Gov.br (nível prata ou ouro).'),
        AccordeonModel(
            title: 'Como corrigir informações do relatório',
            desc:
                'Caso seja identificado algum erro ou seus dados estejam desatualizados, você deve solicitar a retificação junto à instituição (financeira ou participante) na qual a chave foi registrada. \n\nSe o problema não for resolvido, reclame em www.consumidor.gov.br ou pelo Fale Conosco do Banco Central.'),
        AccordeonModel(
            title: 'Prazo de atualização do relatório',
            desc:
                'A atualização do relatório acontece em tempo real. Ou seja, assim que a chave Pix é registrada na instituição, o sistema do Banco Central é informado e o dado é incluído no relatório.'),
      ];

  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
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
        bottom: infooter(),
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
                  const H(16),
                  const HeaderHero(
                    title: 'Chaves PIX',
                    desc:
                        'O Relatório de Chaves Pix mostra as chaves Pix que você cadastrou, vinculadas aos dados de sua conta (nome do banco, número da agência e da conta).',
                  ),
                  const H(16),
                  const HeaderHero(
                    title: 'Para que serve?',
                    desc: 'O relatório serve para você:',
                  ),
                  const H(16),
                  CheckList(_checklist),
                  const H(16),
                  const HeaderHero(
                    title: 'Perguntas Frequentes',
                    desc:
                        'Confira perguntas frequentemente feitas por usuários, e tire suas dúvidas.',
                  ),
                ],
              ),
            ),
            AppAccordeon(_accordeonlist),
            const H(30),
          ],
        ),
      ],
    );
  }

  Widget infooter() {
    return InFooterCta(
      onTap: () => push(
          context,
          RedirectPage(
            'Você será encaminhado para um site oficial do Banco Central.',
            'https://registrato.bcb.gov.br/registrato/',
            titleInfooter: 'IR PARA REGISTRATO',
            child: Column(children: [
              Text('Você será redirecionado para o site oficial do GOV.BR:',
                  style: AppTheme.text.normal.xs(const Color(0xFF474747))),
              Text('registrato.bcb.gov.br',
                  style: AppTheme.text.extra.xs(const Color(0xFF474747)))
            ]),
          )),
      label: 'ACESSAR O REGISTRATO',
      icon: Icons.arrow_forward_rounded,
      invert: true,
    );
  }
}
