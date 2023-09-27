import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class QuizRegrasFrequenciaEscolarPage extends AdStatefulWidget {
  QuizRegrasFrequenciaEscolarPage({Key? key})
      : super(key: key, name: 'QuizRegrasFrequenciaEscolarPage');

  @override
  State<QuizRegrasFrequenciaEscolarPage> createState() => _QuizRegrasFrequenciaEscolarPageState();
}

class _QuizRegrasFrequenciaEscolarPageState extends State<QuizRegrasFrequenciaEscolarPage> {
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
        const AppTitle('Regras de frequência escolar?'),
        const H(16),
        const AppDesc(
            'Crianças de 4 a 5 anos precisam ter uma frequência escolar maior ou igual à 60% dos dias letivos. \n\nCrianças acima de 6 anos precisam ter uma frequência escolar maior ou igual à 75% dos dias letivos.'),
        const H(16),
        const BannerWidget(),
      ],
    );
  }
}
