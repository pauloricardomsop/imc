import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum IMCLevel {
  severamenteAbaixo(Color(0xFF426dff), 0, 15.99, 0, 2),
  muitoAbaixo(Color(0xFF2294ea), 16, 16.99, 2, 6),
  abaixo(Color(0xFF54aef5), 17, 18.49, 6, 13.16),
  normal(Color(0xFF54a52b), 18.5, 24.99, 13.16, 34.21),
  sobrepeso(Color(0xFFfecd2e), 25, 29.99, 34.21, 55.26),
  obesidadeGrau1(Color(0xFFfd9844), 30, 34.99, 55.26, 76.32),
  obesidadeGrau2(Color(0xFFf67d3d), 35, 39.99, 76.32, 97.37),
  obesidadeGrau3(Color(0xFFf04e46), 40, 100, 97.37, 100);

  final Color color;
  final double min;
  final double max;
  final double minChart;
  final double maxChart;

  const IMCLevel(this.color, this.min, this.max, this.minChart, this.maxChart);
}

extension IMCLevelExt on IMCLevel {
  String get label {
    switch (this) {
      case IMCLevel.severamenteAbaixo:
        return 'severely_underweight'.tr();
      case IMCLevel.muitoAbaixo:
        return 'very_underweight'.tr();
      case IMCLevel.abaixo:
        return 'underweight'.tr();
      case IMCLevel.normal:
        return 'normal'.tr();
      case IMCLevel.sobrepeso:
        return 'overweighta'.tr();
      case IMCLevel.obesidadeGrau1:
        return 'obesity_grade_i'.tr();
      case IMCLevel.obesidadeGrau2:
        return 'obesity_grade_ii'.tr();
      case IMCLevel.obesidadeGrau3:
        return 'obesity_grade_iii'.tr();
      default:
        return '';
    }
  }
}
