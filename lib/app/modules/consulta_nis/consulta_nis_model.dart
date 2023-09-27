// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

class ConsultaNisModel {
  TextEditingController cpf = MaskedTextController(mask: '000.000.000-00');
  double progressValue = 0.25;
  String progressString = 'loading_nis_header_progress_string_1';
  String get nisReplaced =>
      cpf.value.text.replaceAll('.', '').replaceAll('-', '');
}
