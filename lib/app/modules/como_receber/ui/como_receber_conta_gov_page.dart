import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/components/quiz_option_widget.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/como_receber/como_receber_controller.dart';
import 'package:svr/app/modules/como_receber/como_receber_model.dart';
import 'package:svr/app/modules/como_receber/ui/como_receber_chave_pix_page.dart';

class ComoReceberContaGovPage extends JourneyStatefulWidget {
  const ComoReceberContaGovPage({Key? key}) : super(key: key, name: 'ComoReceberContaGovPage');

  @override
  State<ComoReceberContaGovPage> createState() => _ComoReceberContaGovPageState();
}

class _ComoReceberContaGovPageState extends State<ComoReceberContaGovPage> {
  final ComoReceberController _controller = ComoReceberController();
  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    super.initState();
  }

  List<QuizOptionModel> quizOptions = [
    QuizOptionModel('Sim'),
    QuizOptionModel('Não'),
    QuizOptionModel('Não sei o que é GOV.BR'),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      active: AdController.adConfig.banner.active,
      behavior: [widget.name],
      bottom: InFooterCta(
        onTap: () {
          if (_controller.comoReceberQuizStream.value.contaGov == null) {
            NotificationService.negative('Selecione uma das opções');
            return;
          }
          push(context, const ComoReceberChavePixPage());
        },
        label: 'PRÓXIMO',
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
              const HeaderHero(
                title: 'Você possui uma conta GOV.BR nível Ouro?',
                desc:
                    'Para saber os valores exatos e seguir com o saque você precisará de uma GOV.BR.',
              ),
              const H(16),
              QuizOptionWidget(
                options: quizOptions,
                option: model.contaGov,
                onChanged: (e) {
                  model.contaGov = e;
                  _controller.comoReceberQuizStream.update();
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
