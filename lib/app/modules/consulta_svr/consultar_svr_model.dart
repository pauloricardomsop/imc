import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:svr/app/core/enums/consulta_valores_tipo.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class ConsultarSVRModel {
  final identifier = TextEditingController(text: '05769335386');
  final date = TextEditingController(text: '15/06/1993');
  final captcha = TextEditingController();

  String imageCaptcha = empty;
  String hashCaptcha = empty;

  ConsultaValoresPessoa pessoa;
  bool get isPessoaFisica => pessoa == ConsultaValoresPessoa.fisica;

  ConsultaValoresPessoaEstado pessoaEstado;
  bool get isFalecido => pessoaEstado == ConsultaValoresPessoaEstado.falecido;

  String get dateFormatted => DateFormat('yyyy-MM-dd')
      .format(DateFormat('dd/MM/yyyy').parse(date.text));

  String get identifierUnmasked => identifier.text
      .replaceAll(' ', '')
      .replaceAll('.', '')
      .replaceAll('-', '')
      .replaceAll('/', '');

  ConsultarSVRModel(this.pessoa, this.pessoaEstado);
}
