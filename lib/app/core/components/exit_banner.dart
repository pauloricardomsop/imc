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
        Header(
          backgroundColor: AppColors.white,
          top: HeaderTop(
            backgroundColor: AppColors.white,
            leading: AppIcon.back(
              backgroundColor: AppColors.surfaceContainer,
              iconColor: AppColors.onSurface,
              onTap: () => Navigator.pop(context),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BannerWidget(),
                const H(24),
                Text(
                  'Conseguimos te ajudar?',
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(color: AppColors.onSurface).titleMedium,
                ),
                const H(16),
                Text(
                  'Sua avaliação é muito importante, deixe\nsua opinião na PlayStore.',
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(color: AppColors.onSurface).titleMedium,
                ),
                const H(24),
                AppButton(
                  label: 'AVALIAR',
                  onTap: () {
                    Navigator.pop(context);
                    sendToStore();
                  },
                ),
                const H(8),
                AppButton.textButtons(
                  label: 'SAIR DO APP',
                  onTap: () => exit(0),
                  icon: Symbols.exit_to_app,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
