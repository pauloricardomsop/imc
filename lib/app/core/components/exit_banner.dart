import 'dart:io';

import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExitBanner extends AdStatefulWidget {
  ExitBanner({
    Key? key,
  }) : super(key: key, name: 'ExitBanner');

  @override
  State<ExitBanner> createState() => ExitBannerState();
}

class ExitBannerState extends State<ExitBanner> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: body(context),
    );
  }

  Widget body(_) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BannerWidget(),
                const H(20),
                const AvaliarCard(),
                const H(24),
                AppButton(
                    label: 'CONTINUAR NO APP',
                    onTap: () => Navigator.pop(context)),
                const H(16),
                AppButton.textButtons(
                  label: 'SAIR DO APP',
                  onTap: () => exit(0),
                  icon: Symbols.logout,
                  backgroundColor: AppColors.surfaceContainer,
                  foregroundColor: AppColors.onSurface,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AvaliarCard extends StatelessWidget {
  const AvaliarCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.surfaceContainer),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('AVALIAR APP',
              style: const TextStyle(color: AppColors.onSurface).titleMedium),
          const H(8),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (var i = 0; i < 5; i++)
              Padding(
                padding: EdgeInsets.only(right: i != 4 ? 10 : 0),
                child: const Icon(
                  Symbols.star_rounded,
                  fill: 1,
                  size: 48,
                  color: Colors.amber,
                ),
              ),
          ]),
          const H(8),
          Container(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0xFFCBD5E1),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ]),
            child: CardFeatures.full([
              CardFeature.full(
                label: 'Valores a Receber\nGuia 2023',
                prefix: 'assets/images/logo.png',
                // sufix: const AppIcon.openInNew(size: 30),
                onTap: () {
                  Navigator.pop(context);
                  sendToStore();
                },
                // backgroundColor: AppColors.surfaceContainerLowest,
              )
            ]),
          )
        ],
      ),
    );
  }
}
