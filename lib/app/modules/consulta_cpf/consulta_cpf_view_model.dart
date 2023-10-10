import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsultaCPFViewModel {
  final TextEditingController cpfEC =
      MaskedTextController(mask: '000.000.000-00');
  final FocusNode cpfFC = FocusNode();

  final TextEditingController dataNascimentoEC =
      MaskedTextController(mask: '00/00/0000');

  final TextEditingController captchaEC = TextEditingController();
  final FocusNode dataNascimentoFC = FocusNode();
  String get dateFormatted => DateFormat('yyyy-MM-dd')
      .format(DateFormat('dd/MM/yyyy').parse(dataNascimentoEC.text));
}
