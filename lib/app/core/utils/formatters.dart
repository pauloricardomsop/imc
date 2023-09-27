import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    text = text.replaceAll(RegExp('[^0-9]'), '');

    double value = double.tryParse(text) ?? 0.0;

    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    String newText = formatter.format(value / 100);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
