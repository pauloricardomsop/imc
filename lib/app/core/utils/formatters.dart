import 'package:flutter/services.dart';

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    int? check;
    if (newValue.text.isNotEmpty) {
      check = int.tryParse(newValue.text);
    }
    return TextEditingValue(
      text: newValue.text.isEmpty || check != null
          ? newValue.text
          : oldValue.text,
      selection: newValue.text.isEmpty || check != null
          ? newValue.selection
          : oldValue.selection,
    );
  }
}

class MaxFormatter extends TextInputFormatter {
  final int length;

  MaxFormatter(this.length);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    bool valid = newValue.text.length <= length;
    return TextEditingValue(
      text: valid ? newValue.text : oldValue.text,
      selection: valid ? newValue.selection : oldValue.selection,
    );
  }
}
