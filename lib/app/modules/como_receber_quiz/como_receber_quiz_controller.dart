import 'package:ad_manager/ad_manager.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/core/enums/consulta_valores_tipo.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/como_receber_quiz/como_receber_quiz_model.dart';
import 'package:svr/app/modules/consulta_svr/ui/consultar_svr_home_page.dart';
import 'package:svr/app/modules/home/home_page.dart';
import 'package:svr/app/modules/home/topics/como_aumentar_nivel_page.dart';
import 'package:svr/app/modules/home/topics/o_que_e_page.dart';

class ComoReceberQuizController {
  static final ComoReceberQuizController _instance =
      ComoReceberQuizController._();

  ComoReceberQuizController._();

  factory ComoReceberQuizController() => _instance;

  AppStream<ComoReceberQuizModel> quizStream =
      AppStream<ComoReceberQuizModel>.seed(ComoReceberQuizModel());

  String get title => quizStream.value.isSuccess ? 'Sucesso!' : 'Atenção.';
  String get image => quizStream.value.isSuccess
      ? 'assets/images/rafiki.svg'
      : 'assets/images/error.svg';
  String get titlePage =>
      quizStream.value.isSuccess ? 'Parabéns!' : 'Ajustes necessários.';
  String get descPage => quizStream.value.isSuccess
      ? 'Você atende aos requisitos para\nconsultar se você possui valores a\nreceber no Sistema SVR.'
      : 'Veja abaixo os pontos que você precisa\najustar antes de consultar os valores a\nreceber.';

  String get labelButtom {
    if (quizStream.value.isSuccess) {
      return 'CONSULTAR VALORES';
    } else if (quizStream.value.isError) {
      return 'CADASTRAR GOV.BR';
    } else {
      return 'NOVAS REGRAS DO SVR';
    }
  }

  Future<void> sendToHomePage(BuildContext context) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );

  void redirectPage(BuildContext context) {
    sendToHomePage(context);
    if (quizStream.value.isSuccess) {
      push(context, ConsultarSVRHomePage(ConsultaValoresPessoaEstado.vivo));
    } else if (quizStream.value.isError) {
      push(context, ComoAumentarNivelPage());
    } else {
      push(context, OQueEPage());
    }
  }

  void dispose() {
    quizStream.add(ComoReceberQuizModel());
  }
}
