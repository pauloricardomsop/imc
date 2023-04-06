import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:flutter/material.dart';

class Close extends StatelessWidget {
  const Close({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AdController.showInterstitialAd(context),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFDD0000))),
        child: const Icon(Icons.close, color: Color(0xFFDD0000)),
      ),
    );
  }
}
