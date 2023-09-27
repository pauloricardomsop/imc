import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class QuizComoSaberCadUnicoPage extends AdStatefulWidget {
  QuizComoSaberCadUnicoPage({Key? key}) : super(key: key, name: 'QuizComoSaberCadUnicoPage');

  @override
  State<QuizComoSaberCadUnicoPage> createState() => _QuizComoSaberCadUnicoPageState();
}

class _QuizComoSaberCadUnicoPageState extends State<QuizComoSaberCadUnicoPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(child: body(context));
  }

  Widget body(_) {
    return AppListView(
      children: [
        Header.light(
          top: HeaderTop(
            backgroundColor: AppColors.white,
            leading: AppIcon.exit(
              backgroundColor: AppColors.surfaceContainer,
              iconColor: AppColors.onSurface,
              onTap: () => Navigator.pop(context),
            ),
          ),
        ),
        const AppTitle('Como saber se meu CadÚnico está atualizado?'),
        const H(16),
        const AppDesc(
            'O usuário poderá verificar se seus dados cadastrais estão atualizados ou não pelo aplicativo do Cadastro Único ou na versão web através do endereço cadunico.cidadania.gov.br. \n\nOutra opção é verificar no CRAS mais próximo de sua casa.'),
        const H(16),
        const BannerWidget(),
      ],
    );
  }
}
