import 'package:flutter/services.dart';

class IncInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (filteredValue.length > 2) {
      filteredValue = filteredValue.substring(0, 2);
    }

    return newValue.copyWith(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }
}
