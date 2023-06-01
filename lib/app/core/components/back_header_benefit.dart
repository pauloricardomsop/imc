import 'package:flutter/material.dart';
import 'package:svr/app/core/components/divisor.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class BackHeader extends StatelessWidget {
  final EdgeInsets? margin;
  final Widget? button;
  final void Function()? onTap;

  const BackHeader({this.margin, this.button, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              // onTap: () => AdController.showInterstitialAd(context),
              onTap: () => pop(context),
              child: Container(
                margin: margin ?? const EdgeInsets.all(16),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFDDE0FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.arrow_back, color: Color(0xFF000C61)),
              ),
            ),
            const Spacer(),
            if (button != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: button!,
              )
          ],
        ),
        const Divisor()
      ],
    );
  }
}
