import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/check_list.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/models/check_list_model.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/como_receber/como_receber_controller.dart';
import 'package:svr/app/modules/como_receber/como_receber_model.dart';

class ComoReceberResultadoPage extends JourneyStatefulWidget {
  const ComoReceberResultadoPage({Key? key})
      : super(key: key, name: 'ComoReceberResultadoPage');

  @override
  State<ComoReceberResultadoPage> createState() =>
      _ComoReceberResultadoPageState();
}

class _ComoReceberResultadoPageState extends State<ComoReceberResultadoPage> {
  final ComoReceberController _controller = ComoReceberController();
  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    super.initState();
  }

  List<CheckListModel> checkItens(ComoReceberQuiz model) => [
        CheckListModel(
          icon: model.possuiCpfData ? Icons.done : Icons.warning_outlined,
          color: model.possuiCpfData
              ? const Color(0xFF1C44F9)
              : const Color(0xFFC10000),
          label: model.possuiCpfData
              ? 'CPF e Data de Nascimento'
              : 'Tenha com você CPF e Data de Nascimento.',
        ),
        CheckListModel(
          icon: model.possuiContaGov ? Icons.done : Icons.warning_outlined,
          color: model.possuiContaGov
              ? const Color(0xFF1C44F9)
              : const Color(0xFFC10000),
          label: model.possuiContaGov
              ? 'Conta GOV.BR Nível Ouro'
              : 'Veja como cadastrar sua conta GOV.BR nível ouro.',
        ),
        CheckListModel(
          icon: model.possuiChavePix ? Icons.done : Icons.warning_outlined,
          color: model.possuiChavePix
              ? const Color(0xFF1C44F9)
              : const Color(0xFFC10000),
          label: model.possuiChavePix
              ? 'Chave PIX Cadastrada.'
              : 'Cadastre sua chave PIX',
        )
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      active: AdController.adConfig.banner.active,
      behavior: [widget.name],
      bottom: InFooterCta(
        onTap: () {
          if (_controller.comoReceberQuizStream.value.chavePix == null) {
            NotificationService.negative('Selecione uma das opções');
            return;
          }
          AdController.showInterstitialTransitionAd(context,
              onComplete: () =>  _controller.comoReceberQuizStream.value.page(context));
        },
        label: _controller.comoReceberQuizStream.value.labelFooter,
        icon: Icons.arrow_forward,
        invert: true,
      ),
      child: StreamOut(
        stream: _controller.comoReceberQuizStream.listen,
        child: (context, model) => body(context, model),
      ),
    );
  }

  Widget body(_, ComoReceberQuiz model) {
    return Column(
      children: [
        const BackHeader(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              HeaderHero(
                title: model.titleResult,
                desc: model.descResult,
              ),
              const H(16),
              CheckList(checkItens(model))
            ],
          ),
        ),
      ],
    );
  }

 
}
