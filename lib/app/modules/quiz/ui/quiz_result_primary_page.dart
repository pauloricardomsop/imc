import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/atendimento/topics/atendimento_presencial_page.dart';
import 'package:svr/app/modules/quiz/quiz_controller.dart';
import 'package:svr/app/modules/quiz/quiz_model.dart';
import 'package:svr/app/modules/quiz/ui/quiz_quantidade_filhos_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class QuizResultPrimaryPage extends AdStatefulWidget {
  QuizResultPrimaryPage({Key? key})
      : super(key: key, name: 'QuizResultPrimaryPage');

  @override
  State<QuizResultPrimaryPage> createState() => _QuizResultPrimaryPageState();
}

class _QuizResultPrimaryPageState extends State<QuizResultPrimaryPage> {
  final QuizController quizController = QuizController();
  List<CardFeature> get listCard => [
        CardFeature.full(
            label: 'Ver valores e \nrequisitos',
            prefix: Symbols.tv_options_edit_channels,
            onTap: () => push(context, QuizQuantidadeFilhosPage())),
        CardFeature.full(
          label: 'Encontrar \num CRAS',
          prefix: Symbols.pin_drop,
          onTap: () => push(context, AtendimentoPresencialPage()),
        ),
        CardFeature.full(
          label: 'Visitar o site do \nBolsa Família',
          prefix: Symbols.captive_portal,
          onTap: () => AdUtils.loadUrl(
              'https://www.gov.br/mds/pt-br/acoes-e-programas/bolsa-familia'),
        ),
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
          backgroundColor:
              model.success ? AppColors.primaryShadow : AppColors.errorShadow,
          top: HeaderTop(
            backgroundColor:
                model.success ? AppColors.primaryShadow : AppColors.errorShadow,
            leading: AppIcon.back(
              backgroundColor:
                  model.success ? AppColors.primaryContainer : AppColors.error,
            ),
            action: AppIcon.logout(onTap: () => pops(context, 4)),
          ),
          title: quizController.titleController,
          desc: quizController.subtitleController,
          buttons: [
            if (model.success) ...[
              AppButton(
                icon: Symbols.trending_flat,
                label: 'VER VALORES E REQUISITOS',
                onTap: () => push(context, QuizQuantidadeFilhosPage()),
              ),
            ],
          ],
          child: Column(
            children: [
              const H(16),
              Row(
                children: [
                  HeaderCard(
                    label: 'Renda \nFamiliar',
                    icon: Icons.attach_money,
                    backgroundColor: model.success
                        ? AppColors.primaryShadow
                        : AppColors.errorShadow,
                    borderColor: model.success
                        ? AppColors.primaryContainer
                        : AppColors.errorContainer,
                    iconColor: model.success
                        ? AppColors.primaryContainer
                        : AppColors.error,
                    title: toMoney(quizController.rendaFamiliarPorPessoa),
                    subtitle: 'Por pessoa',
                  ),
                  const W(8),
                  HeaderCard(
                    label: 'Número de \nPessoas',
                    icon: Icons.attach_money,
                    backgroundColor: model.success
                        ? AppColors.primaryShadow
                        : AppColors.errorShadow,
                    borderColor: model.success
                        ? AppColors.primaryContainer
                        : AppColors.errorContainer,
                    iconColor: model.success
                        ? AppColors.primaryContainer
                        : AppColors.error,
                    title: model.quantidadePessoas.toString(),
                    subtitle: 'Moradores',
                  ),
                ],
              ),
              if (model.success) ...[
                const H(16),
                const AppDesc(
                    'Para saber o valor aproximado do seu benefício, continue respondendo o QUIZ clicando no botão abaixo.',
                    color: AppColors.surfaceContainerLowest),
              ],
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppTitle('Atenção, continue lendo...'),
            const H(24),
            const BannerWidget(),
            const H(24),
            AppDesc(model.success
                ? 'Você atende as regras principais do Novo Bolsa Família, no entanto é necessário cumprir alguns requisitos para receber mais que os R\$ 600 estabelecidos pelo programa. Continue respondendo o formulário para '
                : 'Você pode buscar um CRAS para obter informações mais precisas sobre seu enquadramento no Novo Bolsa Família.'),
            const H(16),
            if (model.success) ...[
              CardFeatures.full([listCard[0]]),
              const H(16),
            ],
            if (!model.success) ...[
              CardFeatures.full([listCard[1]]),
              const H(16),
              CardFeatures.full([listCard[2]]),
            ],
          ],
        ),
      ],
    );
  }
}
