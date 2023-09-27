import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/formatters.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/quiz_controller.dart';
import 'package:svr/app/modules/quiz/quiz_model.dart';
import 'package:svr/app/modules/quiz/ui/quiz_quantidade_pessoas_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class QuizRendaFamiliarPage extends AdStatefulWidget {
  QuizRendaFamiliarPage({Key? key})
      : super(key: key, name: 'QuizRendaFamiliarPage');

  @override
  State<QuizRendaFamiliarPage> createState() => _QuizRendaFamiliarPageState();
}

class _QuizRendaFamiliarPageState extends State<QuizRendaFamiliarPage> {
  final QuizController _controller = QuizController();

  List<QuizOptionModel> quizOptions = [
    QuizOptionModel('SIM'),
    QuizOptionModel('NÃO'),
  ];

  @override
  void dispose() {
    _controller.quizStream.add(QuizModel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(
        AppButton(
          label: 'PRÓXIMO',
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () => push(context, QuizQuantidadePessoasPage())),
          icon: Symbols.trending_flat,
        ),
      ),
      child: StreamOut<QuizModel>(
        stream: _controller.quizStream.listen,
        child: (_, model) => body(context, model),
      ),
    );
  }

  Widget body(_, QuizModel model) {
    return AppListView(
      children: [
        Header.light(
          top: HeaderTop(
            backgroundColor: AppColors.white,
            leading: const AppIcon.back(
                backgroundColor: AppColors.surfaceContainer,
                iconColor: AppColors.onSurface),
            action: AppIcon.logout(onTap: () => pops(context, 1)),
          ),
        ),
        const AppTitle(
            'Qual a soma total da renda de todas as pessoas que moram em sua residência?'),
        AppField(
          controller: model.rendaFamiliar,
          label: '',
          hint: 'R\$ 0,00',
          inputFormatters: [
            CurrencyInputFormatter(),
          ],
          onChanged: (e) => _controller.quizStream.update(),
          icon: Symbols.attach_money,
          type: const TextInputType.numberWithOptions(
              decimal: false, signed: false),
        ),
        const H(24),
        const BannerWidget(),
      ],
    );
  }
}
