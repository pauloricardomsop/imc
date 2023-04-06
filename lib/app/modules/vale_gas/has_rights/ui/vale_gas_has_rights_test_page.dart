import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/ad_icon.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/button_icon.dart';
import 'package:benefits_brazil/app/core/components/card_sm.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/stream_out.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:benefits_brazil/app/core/models/card_sm_model.dart';
import 'package:benefits_brazil/app/core/theme/app_theme.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/vale_gas/has_rights/vale_gas_has_rights_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../vale_gas_has_rights_model.dart';

class ValeGasHasRightsTestPage extends JourneyStatefulWidget {
  const ValeGasHasRightsTestPage({super.key}) : super(name: 'ValeGasHasRightsTestPage');

  @override
  State<ValeGasHasRightsTestPage> createState() => _ValeGasHasRightsTestPage();
}

class _ValeGasHasRightsTestPage extends State<ValeGasHasRightsTestPage> {
  final ValeGasHasRightsController _valeGasQuizController = ValeGasHasRightsController();

  final List<CardSmModel> _cardItens = [
    CardSmModel(
      title: 'Como se cadastrar',
      subtitle: 'Aprenda como se cadastrar e como manter seu benefício Bolsa Família atualizado.',
      page: Container(),
    ),
    CardSmModel(
      title: 'Calendário atualizado',
      subtitle: 'Fique atualizado sobre a data de pagamentos do seu benefício.',
      page: Container(),
    ),
    CardSmModel(
      title: 'Últimas notícias',
      subtitle: 'Encontre as últimas notícias sobre o programa Bolsa Família.',
      page: Container(),
    ),
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
    return WillPopScope(
      onWillPop: () async => false,
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.get(widget.name),
        body: StreamOut<ValeGasHasRightsQuizValues>(
          stream: _valeGasQuizController.quizValuesStream.listen,
          child: (_, values) => body(_, values),
        ),
      ),
    );
  }

  Widget body(_, ValeGasHasRightsQuizValues values) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const BackHeaderBenefit(benefit: Benefit.valeGas),
        const H(32),
        _approvedLevel(context, values),
        const H(16),
        Text(
          'Responda aos questionários abaixo para saber seu nível de aprovação.',
          style: AppTheme.text.normal.base(const Color(0xFF474747)),
        ),
        const H(16),
        AppBannerAd(AdBannerStorage.get(widget.name)),
        const H(16),
        if (values.pointsQuizOne == null)
          _quizItem(_, 'https://ldcapps.com/wp-content/uploads/2023/03/saudeeducacao.jpg', '1', 'Saúde e Educação', '1 min',
              ValeGasHasRightsQuiz.quizSaudeEducacao(context)),
        const H(16),
        if (values.pointsQuizTwo == null)
          _quizItem(_, 'https://ldcapps.com/wp-content/uploads/2023/03/baixa-renda.jpeg', '2', 'Renda Familiar', '30 seg',
              ValeGasHasRightsQuiz.quizRendaFamiliar(context)),
        if (values.pointsQuizOne != null && values.pointsQuizTwo != null)
          ..._cardItens
              .map((e) => CardSm(
                    onTap: () => push(context, e.page),
                    title: e.title,
                    subtitle: e.subtitle,
                  ))
              .toList(),
        const H(32),
      ],
    );
  }

  Container _quizItem(
      _, String image, String quizIndex, String title, String duration, Widget page) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE3E2E2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.maxFinite,
              height: 160,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                )
            ),
          ),
          const H(16),
          Text(
            'Quiz $quizIndex de 2',
            style: AppTheme.text.normal.sm(const Color(0xFF1B1C1C)),
          ),
          Text(
            title,
            style: AppTheme.text.extra.xl3(const Color(0xFF1B1C1C)),
          ),
          const H(8),
          Container(
            width: double.maxFinite,
            height: 0.5,
            color: const Color(0xFFE3E2E2),
          ),
          const H(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tempo Estimado',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
              Text(
                duration,
                style: AppTheme.text.semi.base(const Color(0xFF474747)),
              ),
            ],
          ),
          const H(24),
          ButtonIcon(
            onTap: () async {
              AdController.showRewardAd(onComplete: () async {
                await push(context, page);
                setState(() {});
              });
            },
            icon: const AdIcon(),
            label: 'Ir para o teste',
          ),
        ],
      ),
    );
  }

  Widget _approvedLevel(BuildContext context, ValeGasHasRightsQuizValues values) {
    final List<QuizPoint> points = [
      if (values.pointsQuizOnePercent != null) QuizPoint(values.pointsQuizOnePercent!),
      if (values.pointsQuizTwo != null) QuizPoint(values.pointsQuizTwoPercent!),
    ];
    int progress = 0;
    if (points.isNotEmpty) {
      progress = points.first.point.toInt();
    }
    if (points.length == 2) {
      progress = points.first.point.toInt() + points.last.point.toInt();
    }
    if (progress >= 100) {
      final diff = progress - 99;
      progress = 99;
      points.last.point -= diff;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
          color: const Color(0xFFFEFCFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE3E2E2))),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nível de aprovação',
                style: AppTheme.text.extra.xl2(const Color(0xFF1B1C1C)),
              ),
              const H(10),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Suas chances de aprovação',
                    style: AppTheme.text.normal.sm(const Color(0xFF474747)),
                  )),
                  Text(
                    '$progress%',
                    style: AppTheme.text.semi.sm(const Color(0xFF474747)),
                  )
                ],
              ),
              const H(8),
              LinearProgressIndicator(
                value: progress == 0 ? 0 : progress / 100,
                backgroundColor: const Color(0xFFE3E2E2),
                valueColor: const AlwaysStoppedAnimation(Color(0xFF006D3C)),
              )
            ],
          ),
          if (points.length == 1)
            Positioned(
              right: 0,
              bottom: 32,
              child: Text(
                '+${points.first.point.toInt()}%',
                style: AppTheme.text.semi.sm(const Color(0xFF006D3C).withOpacity(0.3)),
              ),
            ),
          if (points.length == 2)
            ...points.map((e) {
              bool isFirst = points.indexOf(e) == 0;
              return Positioned(
                right: 0,
                bottom: !isFirst ? 32 : 52,
                child: Text(
                  '+${e.point.toInt()}%',
                  style: AppTheme.text.semi
                      .sm(const Color(0xFF006D3C).withOpacity(!isFirst ? 0.3 : 0.1)),
                ),
              );
            }).toList()
        ],
      ),
    );
  }
}
