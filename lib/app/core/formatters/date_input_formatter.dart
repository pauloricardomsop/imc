import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var dateText = _addSlashes(newValue.text);
    return TextEditingValue(
      text: dateText,
      selection: TextSelection.collapsed(offset: dateText.length),
    );
  }

  String _addSlashes(String inputString) {
    if (inputString.length > 10) {
      return inputString.substring(0, 10);
    }
    var formattedString = inputString;
    if (inputString.length >= 3 && !inputString.contains("/")) {
      formattedString =
          '${inputString.substring(0, 2)}/${inputString.substring(2)}';
    }
    if (inputString.length >= 6) {
      var firstSlash = inputString.indexOf("/");
      if (firstSlash != -1 &&
          inputString.substring(firstSlash + 1).contains("/")) {
        formattedString = inputString;
      } else {
        formattedString =
            '${inputString.substring(0, 5)}/${inputString.substring(5)}';
      }
    }
    return formattedString;
  }
}
