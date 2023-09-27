import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/home/home_page.dart';
import 'package:svr/app/modules/quiz/quiz_controller.dart';
import 'package:svr/app/modules/quiz/quiz_model.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class QuizResultSecondPage extends AdStatefulWidget {
  QuizResultSecondPage({Key? key})
      : super(key: key, name: 'QuizResultSecondPage');

  @override
  State<QuizResultSecondPage> createState() => _QuizResultSecondPageState();
}

class _QuizResultSecondPageState extends State<QuizResultSecondPage> {
  final QuizController quizController = QuizController();
  List<CheckListModel> get checklistDocumentos => [
        CheckListModel(
            label: 'Renda por pessoa dentro do limite de R\$ 218,00',
            icon: Symbols.check_circle,
            color: AppColors.primary),
        (quizController.quizStream.value.getPossuiCaastroAtualizado)
            ? CheckListModel(
                label: 'CadÚnico atualizado',
                icon: Symbols.check_circle,
                color: AppColors.primary)
            : CheckListModel(
                label: 'Atualize seu CadÚnico',
                icon: Symbols.error,
                color: AppColors.error),
        (quizController.quizStream.value.getPossuiCartaoVacinaFilhos0a6)
            ? CheckListModel(
                label: 'Vacinas em dias',
                icon: Symbols.check_circle,
                color: AppColors.primary)
            : CheckListModel(
                label:
                    'Atualize o cartão de vacinas das crianças de até 6 anos de idade.',
                icon: Symbols.error,
                color: AppColors.error),
        (quizController.quizStream.value.getPossuiFilhos4a18FrequentandoEscola)
            ? CheckListModel(
                label: 'Frequência escolar em dia',
                icon: Symbols.check_circle,
                color: AppColors.primary)
            : CheckListModel(
                label:
                    'Regularize a frequência escolar das crianças ou adolescentes de 4 a 18 anos.',
                icon: Symbols.error,
                color: AppColors.error),
        (quizController.quizStream.value.getPossuiGestantePreNatalEmDia)
            ? CheckListModel(
                label: 'Pré-natal em dia',
                icon: Symbols.check_circle,
                color: AppColors.primary)
            : CheckListModel(
                label: 'Regularize o pré-natal das gestantes de sua casa.',
                icon: Symbols.error,
                color: AppColors.error),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: StreamOut<QuizModel>(
        stream: quizController.quizStream.listen,
        child: (_, model) => body(_, model),
      ),
    );
  }

  Widget body(_, QuizModel model) {
    return AppListView(
      children: [
        Header(
          backgroundColor: AppColors.primaryShadow,
          top: HeaderTop(
            leading: AppIcon.back(
              onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) => false,
              ),
            ),
            action: AppIcon.logout(onTap: () => pops(context, 11)),
          ),
          title: 'Valor calculado',
          desc:
              'Com base nas respostas fornecidas o valor final do seu benefício deve ser de:',
          child: Column(
            children: [
              const H(16),
              Row(children: [_userRendaInfo(model)]),
            ],
          ),
        ),
        const H(16),
        (model.getPossuiAlertas)
            ? CardAlert.warning(
                'Existem alertas abaixo!',
                const TextStyle(color: AppColors.warningShadow).labelLarge,
                borderRadius: BorderRadius.circular(12),
              )
            : const SizedBox(),
        const H(16),
        const AppTitle('Atenção, continue lendo...'),
        const H(24),
        const BannerWidget(),
        const H(24),
        const AppDesc(
            'Este valor é somente uma simulação com base nos dados fornecidos e não tem valor legal.'),
        const H(16),
        const AppTitle('Com base em suas resposta você está apto a participar'),
        const H(24),
        CheckList(checklistDocumentos),
      ],
    );
  }
}

Widget _userRendaInfo(QuizModel model) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: model.success ? AppColors.primaryShadow : AppColors.errorShadow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color:
                model.success ? AppColors.primaryContainer : AppColors.error),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Valor Estimado do \nBenefício',
                  style:
                      const TextStyle(color: AppColors.surfaceContainerLowest)
                          .titleSmall,
                ),
              ),
              Icon(
                Icons.attach_money,
                color: model.success ? AppColors.primary : AppColors.error,
              )
            ],
          ),
          const H(18),
          Text(
            toMoney(model.estimacaoBeneficio),
            style: const TextStyle(color: AppColors.surfaceContainerLowest)
                .titleLarge,
          ),
          const H(4),
          Text(
            'Benefício pago mensalmente',
            style: const TextStyle(color: AppColors.surfaceContainerLowest)
                .labelSmall,
          ),
        ],
      ),
    ),
  );
}
