import 'package:flutter/material.dart';
import 'package:svr/app/core/components/quiz_option_widget.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_valores/consulta_valores_page.dart';
import 'package:svr/app/modules/home/home_page.dart';
import 'package:svr/app/modules/home/topics/aumentar_nivel_page.dart';
import 'package:svr/app/modules/home/topics/oque_e_page.dart';

class ComoReceberQuiz {
  QuizOptionModel? cpfData;
  QuizOptionModel? contaGov;
  QuizOptionModel? chavePix;

  bool get possuiCpfData => cpfData!.label == 'Sim';
  bool get possuiContaGov => contaGov!.label == 'Sim';
  bool get possuiChavePix => chavePix!.label == 'Sim';

  String get titleResult => possuiCpfData && possuiContaGov && possuiChavePix
      ? 'Parabéns!'
      : 'Ajustes necessários.';

  String get descResult => possuiCpfData && possuiContaGov && possuiChavePix
      ? 'Você atende aos requisitos para consultar se você possui valores a receber no Sistema SVR.'
      : 'Veja abaixo os pontos que você precisa ajustar antes de consultar os valores a receber.';

  String get labelFooter {
    if (possuiCpfData && possuiContaGov && possuiChavePix) {
      return 'CONSULTAR VALORES';
    }
    if (!possuiCpfData && !possuiContaGov && !possuiChavePix) {
      return 'CADASTRAR GOV.BR';
    }
    return 'NOVAS REGRAS DO SVR';
  }

  Function page(BuildContext context) {
    if (possuiCpfData && possuiContaGov && possuiChavePix) {
      return () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
        push(context, const ConsultaValoresPage());
      };
    }
    if (!possuiCpfData && !possuiContaGov && !possuiChavePix) {
      return () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
        push(context, const AumentarNivelPage());
      };
    }
    return () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
      push(context, const OqueEPage());
    };
  }
}
