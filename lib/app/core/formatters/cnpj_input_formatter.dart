import 'package:flutter/services.dart';

class CNPJInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (filteredText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    if (filteredText.length <= 2) {
      return newValue.copyWith(
        text: filteredText,
        selection: TextSelection.collapsed(offset: filteredText.length),
      );
    } else if (filteredText.length <= 5) {
      return newValue.copyWith(
        text: '${filteredText.substring(0, 2)}.${filteredText.substring(2)}',
        selection: TextSelection.collapsed(offset: filteredText.length + 1),
      );
    } else if (filteredText.length <= 8) {
      return newValue.copyWith(
        text:
            '${filteredText.substring(0, 2)}.${filteredText.substring(2, 5)}.${filteredText.substring(5)}',
        selection: TextSelection.collapsed(offset: filteredText.length + 2),
      );
    } else if (filteredText.length <= 12) {
      return newValue.copyWith(
        text:
            '${filteredText.substring(0, 2)}.${filteredText.substring(2, 5)}.${filteredText.substring(5, 8)}/${filteredText.substring(8)}',
        selection: TextSelection.collapsed(offset: filteredText.length + 3),
      );
    } else if (filteredText.length <= 14) {
      return newValue.copyWith(
        text:
            '${filteredText.substring(0, 2)}.${filteredText.substring(2, 5)}.${filteredText.substring(5, 8)}/${filteredText.substring(8, 12)}-${filteredText.substring(12)}',
        selection: TextSelection.collapsed(offset: filteredText.length + 4),
      );
    } else {
      return newValue.copyWith(
        text:
            '${filteredText.substring(0, 2)}.${filteredText.substring(2, 5)}.${filteredText.substring(5, 8)}/${filteredText.substring(8, 12)}-${filteredText.substring(12, 14)}',
        selection: TextSelection.collapsed(offset: newValue.text.length - 1),
      );
    }
  }
}
