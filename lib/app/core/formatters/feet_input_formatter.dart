import 'package:flutter/services.dart';

class FeetInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (filteredValue.length > 1) {
      filteredValue = filteredValue.substring(0, 1);
    }

    return newValue.copyWith(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }
}
