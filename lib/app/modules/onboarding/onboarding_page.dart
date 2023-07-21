import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_image.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/check_list.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/models/check_list_model.dart';
import 'package:svr/app/core/utils/utils_controller.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPage();
}

class _OnboardingPage extends State<OnboardingPage> {
  final UtilsController _utilsController = UtilsController();

  final List<CheckListModel> _checkList = [
    CheckListModel(icon: Icons.done, label: 'Como se inscrever no CadÚnico'),
    CheckListModel(icon: Icons.done, label: 'Consulta de cadastros'),
    CheckListModel(icon: Icons.done, label: 'Lista de benefícios'),
    CheckListModel(icon: Icons.done, label: 'Como atualizar seu CadÚnico'),
    CheckListModel(icon: Icons.done, label: 'Mapa de unidades de atendimento'),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: InFooterCta(
        onTap: () => AdController.showInterstitialTransitionAd(
          context,
          onComplete: () => _utilsController.setShowOnboarding(false),
        ),
        icon: Icons.arrow_forward,
        label: 'CONTINUAR',
        invert: true,
      ),
      child: body(context),
    );
  }

  Widget body(_) {
    return AppListView(
      padding: EdgeInsets.zero,
      children: [
        const AppImage(
          url: 'assets/images/onboarding.png',
          height: 180,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const HeaderHero(
                title: 'Olá, seja bem-vindo ao Valores a Receber Guia 2023',
                desc:
                    'Aqui você vai encontrar informações úteis de fontes confiáveis sobre esse sistema de cadastro, e outras funcionalidades:',
              ),
              const H(24),
              CheckList(_checkList),
            ],
          ),
        )
      ],
    );
  }
}
