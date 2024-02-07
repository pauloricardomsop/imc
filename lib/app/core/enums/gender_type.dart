import 'package:easy_localization/easy_localization.dart';

enum GenderType {
  male,
  female;
}

extension GenterTypeExt on GenderType {
  String get name {
    switch (this) {
      case GenderType.male:
        return 'male'.tr();
      case GenderType.female:
        return 'female'.tr();
      default:
        return '';
    }
  }
}
