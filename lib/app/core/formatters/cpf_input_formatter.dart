import 'package:flutter/services.dart';

class CPFInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (filteredText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    if (filteredText.length <= 3) {
      return newValue.copyWith(
        text: filteredText,
        selection: TextSelection.collapsed(offset: filteredText.length),
      );
    } else if (filteredText.length <= 6) {
      return newValue.copyWith(
        text: '${filteredText.substring(0, 3)}.${filteredText.substring(3)}',
        selection: TextSelection.collapsed(offset: filteredText.length + 1),
      );
    } else if (filteredText.length <= 9) {
      return newValue.copyWith(
        text:
            '${filteredText.substring(0, 3)}.${filteredText.substring(3, 6)}.${filteredText.substring(6)}',
        selection: TextSelection.collapsed(offset: filteredText.length + 2),
      );
    } else if (filteredText.length <= 11) {
      return newValue.copyWith(
        text:
            '${filteredText.substring(0, 3)}.${filteredText.substring(3, 6)}.${filteredText.substring(6, 9)}-${filteredText.substring(9)}',
        selection: TextSelection.collapsed(offset: filteredText.length + 3),
      );
    } else {
      return newValue.copyWith(
        text:
            '${filteredText.substring(0, 3)}.${filteredText.substring(3, 6)}.${filteredText.substring(6, 9)}-${filteredText.substring(9, 11)}',
        selection: TextSelection.collapsed(offset: newValue.text.length - 1),
      );
    }
  }
}
