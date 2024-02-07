import 'package:flutter/services.dart';

class CentimeterFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Extract only numbers and dot from the new value
    String filteredValue = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Limit total characters to 6
    if (filteredValue.length > 5) {
      filteredValue = filteredValue.substring(0, 5);
    }

    // Allow only two numbers after the dot
    if (filteredValue.contains('.')) {
      List<String> parts = filteredValue.split('.');
      if (parts.length > 1) {
        String decimalPart = parts[1];
        if (decimalPart.length > 1) {
          decimalPart = decimalPart.substring(0, 1);
          filteredValue = '${parts[0]}.$decimalPart';
        }
      }
    }

    // Return the formatted value
    return newValue.copyWith(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }
}
