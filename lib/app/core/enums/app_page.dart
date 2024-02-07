import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum AppPage { calculator, imc, statistics }

extension AppPageExtension on AppPage {
  int get index => AppPage.values.indexOf(this);

  String get name {
    switch (this) {
      case AppPage.calculator:
        return 'calculator'.tr();
      case AppPage.imc:
        return 'bmi'.tr();
      case AppPage.statistics:
        return 'statistics'.tr();
      default:
        return '';
    }
  }

  IconData get icon {
    switch (this) {
      case AppPage.calculator:
        return Icons.calculate;
      case AppPage.imc:
        return Icons.speed;
      case AppPage.statistics:
        return Icons.bar_chart_rounded;
      default:
        return Icons.abc;
    }
  }
}
