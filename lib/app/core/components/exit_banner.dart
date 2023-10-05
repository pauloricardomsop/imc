import 'dart:io';
import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class ExitBanner extends AdStatefulWidget {
  ExitBanner({
    Key? key,
  }) : super(key: key, name: 'ExitBanner');

  @override
  State<ExitBanner> createState() => ExitBannerState();
}

class ExitBannerState extends State<ExitBanner> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: AppColors.surfaceContainerLowest,
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BannerWidget(),
                  const H(20),
                  RateApp(onTap: () => pop(context)),
                  const H(24),
                  AppButton(label: 'CONTINUAR NO APP', onTap: () => Navigator.pop(context)),
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
      ),
    );
  }
}
