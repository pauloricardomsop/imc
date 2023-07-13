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
import 'package:svr/app/modules/como_receber/ui/como_receber_conta_gov_page.dart';

class ComoReceberCpfDataPage extends JourneyStatefulWidget {
  const ComoReceberCpfDataPage({Key? key}) : super(key: key, name: 'ComoReceberCpfDataPage');

  @override
  State<ComoReceberCpfDataPage> createState() => _ComoReceberCpfDataPageState();
}

class _ComoReceberCpfDataPageState extends State<ComoReceberCpfDataPage> {
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
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      active: AdController.adConfig.banner.active,
      behavior: [widget.name],
      bottom: InFooterCta(
        onTap: () {
          if (_controller.comoReceberQuizStream.value.cpfData == null) {
            NotificationService.negative('Selecione uma das opções');
            return;
          }
          push(context, const ComoReceberContaGovPage());
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
                title: 'Está com CPF e Data de Nascimento das pessoas que você quer verificar?',
                desc:
                    'No sistema de Valores a Receber você pode receber para você ou para falecidos de sua família.',
              ),
              const H(16),
              QuizOptionWidget(
                options: quizOptions,
                option: model.cpfData,
                onChanged: (e) {
                  model.cpfData = e;
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
