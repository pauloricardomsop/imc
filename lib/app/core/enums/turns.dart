import 'package:easy_localization/easy_localization.dart';

enum Turn { morning, afternoon, night }

extension TurnExt on Turn {
  String get label {
    switch (this) {
      case Turn.morning:
        return 'morning'.tr();
      case Turn.afternoon:
        return 'afternoon'.tr();
      case Turn.night:
        return 'night'.tr();
      default:
        return 'morning'.tr();
    }
  }
}
