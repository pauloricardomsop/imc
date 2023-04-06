import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/card_xs.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:flutter/material.dart';

class BackHeaderBenefit extends StatelessWidget {
  final Benefit? benefit;

  const BackHeaderBenefit({this.benefit, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => AdController.showInterstitialAd(context),
          child: Container(
            margin: benefit != null ? const EdgeInsets.only(top: 12) : null,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1C44F9))),
            child: const Icon(Icons.arrow_back, color: Color(0xFF1C44F9)),
          ),
        ),
        const Spacer(),
        if (benefit != null) CardXs(benefit: benefit!)
      ],
    );
  }
}
