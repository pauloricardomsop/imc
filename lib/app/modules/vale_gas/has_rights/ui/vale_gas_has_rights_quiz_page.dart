import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/close.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/in_footer_cta.dart';
import 'package:benefits_brazil/app/core/models/quiz_model.dart';
import 'package:benefits_brazil/app/core/theme/app_theme.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/vale_gas/has_rights/vale_gas_has_rights_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../core/components/w.dart';

class ValeGasHasRightsQuizPage extends JourneyStatefulWidget {
  final Quiz quiz;

  const ValeGasHasRightsQuizPage(this.quiz, {Key? key})
      : super(key: key, name: 'ValeGasHasRightsQuizPage$quiz');

  @override
  State<ValeGasHasRightsQuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<ValeGasHasRightsQuizPage> {
  final ValeGasHasRightsController _valeGasQuizController = ValeGasHasRightsController();

  BannerAd? banner;

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
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: AppScaffold(
          active: AdController.adConfig.banner.active,
          behavior: AdBannerStorage.get(widget.name),
          body: body(context)),
    );
  }

  Widget body(_) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Row(
                children: [
                  const Close(),
                  const Spacer(),
                  _progressIndicator(),
                ],
              ),
              const H(16),
              Text(
                widget.quiz.title,
                style: AppTheme.text.extra.xl3(const Color(0xFF1B1C1C)),
              ),
              if (widget.quiz.subtitle != null) const H(8),
              if (widget.quiz.subtitle != null)
                Text(
                  widget.quiz.subtitle!,
                  style: AppTheme.text.normal.base(const Color(0xFF474747)),
                ),
              const H(32),
              Row(
                children: [
                  Expanded(child: _itemOption(widget.quiz.options[0])),
                  const W(8),
                  Expanded(child: _itemOption(widget.quiz.options[1])),
                ],
              ),
              if (widget.quiz.options.length == 3) _itemOption(widget.quiz.options[2]),
              const H(16),
              AppBannerAd(
                AdBannerStorage.get(widget.name),
              ),
              const H(24),
            ],
          ),
        ),
        InFooterCtaTemporary(
          onTap: () {
            if (widget.quiz.option != null) {
              widget.quiz.option!.onTap.call();
            }
          },
          icon: Icons.arrow_forward,
          label: 'Próxima Pergunta',
          invert: true,
        ),
      ],
    );
  }

  Widget _itemOption(QuizOption e) {
    bool isSelected = e == widget.quiz.option;
    return InkWell(
      onTap: () {
        setState(() {
          widget.quiz.option = e;
        });
      },
      child: IgnorePointer(
        ignoring: true,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              border:
                  Border.all(color: isSelected ? const Color(0xFF1C44F9) : const Color(0xFFE3E2E2)),
              color: isSelected ? const Color(0xFF1C44F9) : const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.only(bottom: 8),
          width: double.maxFinite,
          child: Row(
            children: [
              Radio<QuizOption>(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                value: e,
                groupValue: widget.quiz.option,
                focusColor: isSelected ? const Color(0xFFFFFFFF) : const Color(0xFF1B1C1C),
                hoverColor: isSelected ? const Color(0xFFFFFFFF) : const Color(0xFF1B1C1C),
                activeColor: const Color(0xFFFFFFFF),
                overlayColor: MaterialStateProperty.all(
                    isSelected ? const Color(0xFFFFFFFF) : const Color(0xFF1B1C1C)),
                fillColor: MaterialStateProperty.all(
                    isSelected ? const Color(0xFFFFFFFF) : const Color(0xFF1B1C1C)),
                onChanged: (value) {},
              ),
              const W(8),
              Text(
                e.label,
                style: AppTheme.text.normal
                    .base(isSelected ? const Color(0xFFFFFFFF) : const Color(0xFF1B1C1C))
                    .copyWith(height: 1),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _progressIndicator() => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
              color: const Color(0xFFFEFCFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE3E2E2))),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Progesso',
                    style: AppTheme.text.normal.sm(const Color(0xFF474747)),
                  )),
                  Text(
                    '${widget.quiz.percentage.toInt()}%',
                    style: AppTheme.text.semi.sm(const Color(0xFF474747)),
                  )
                ],
              ),
              const H(8),
              LinearProgressIndicator(
                value: widget.quiz.percentage / 100,
                backgroundColor: const Color(0xFFE3E2E2),
                valueColor: const AlwaysStoppedAnimation(Color(0xFF006D3C)),
              )
            ],
          ),
        ),
      );
}
