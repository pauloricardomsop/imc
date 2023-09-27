import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  double moneyToDouble() {
    return double.parse(replaceAll('R\$', '').replaceAll(',', '.'));
  }
}

extension DateTimeExtension on DateTime {
  String get toBeneficiosApi {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ')
      .replaceAll('De', 'de');
}
