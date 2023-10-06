import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }


  String toCPF() {
    return replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d{3})(\d{2})'),
        (Match m) => '${m[1]}.${m[2]}.${m[3]}-${m[4]}');
  }
  String toCNPJ() {
    return replaceAllMapped(RegExp(r'(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})'),
        (Match m) => '${m[1]}.${m[2]}.${m[3]}/${m[4]}-${m[5]}');
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