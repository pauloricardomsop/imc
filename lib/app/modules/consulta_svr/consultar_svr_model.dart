import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:svr/app/core/enums/consulta_valores_tipo.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class ConsulteValoresModel {
  final identifier = TextEditingController();
  final date = TextEditingController();
  final captcha = TextEditingController();

  String imageCaptcha = empty;
  String hashCaptcha = empty;

  ConsultaValoresPessoa pessoa;
  bool get isPessoaFisica => pessoa == ConsultaValoresPessoa.fisica;

  String get dateFormatted => DateFormat('yyyy-MM-dd')
      .format(DateFormat('dd/MM/yyyy').parse(date.text));

  String get identifierUnmasked => identifier.text
      .replaceAll(' ', '')
      .replaceAll('.', '')
      .replaceAll('-', '')
      .replaceAll('/', '');

  ConsulteValoresModel(this.pessoa);
}