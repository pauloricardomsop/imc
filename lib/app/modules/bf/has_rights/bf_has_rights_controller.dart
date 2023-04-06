import 'package:benefits_brazil/app/core/models/app_stream.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/bf/bf_home_page.dart';
import 'package:benefits_brazil/app/modules/bf/has_rights/bf_has_rights_model.dart';
import 'package:benefits_brazil/app/modules/bf/has_rights/ui/bf_has_rights_home_page.dart';
import 'package:benefits_brazil/app/modules/bf/has_rights/ui/bf_has_rights_test_page.dart';
import 'package:flutter/material.dart';

class BfHasRightsController {
  static final BfHasRightsController _bfQuizController = BfHasRightsController._();

  BfHasRightsController._();

  factory BfHasRightsController() => _bfQuizController;

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  BuildContext get context => key.currentState!.context;

  AppStream<BfHasRightsQuizValues> quizValuesStream =
      AppStream<BfHasRightsQuizValues>.seed(BfHasRightsQuizValues());

  void setQuizOneValue(List<BfQuizQuestion> answers) {
    double point = 0;
    for (var answer in answers) {
      switch (answer.type) {
        case BfQuizQuestionTypeEnum.vacinasAtualizadas:
          if (answer.answer) {
            point += 12.5;
          }
          break;
        case BfQuizQuestionTypeEnum.moramPesosaGestante:
          if (!answer.answer) {
            point += 25;
          }
          break;
        case BfQuizQuestionTypeEnum.preNataisEmDia:
          if (answer.answer) {
            point += 25;
          }
          break;
        case BfQuizQuestionTypeEnum.moramCriacas0a5:
          if (!answer.answer) {
            point += 25;
          }
          break;
        case BfQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual60PorcntEscola:
          if (answer.answer) {
            point += 25;
          }
          break;
        case BfQuizQuestionTypeEnum.moramCriancas6A18Anos:
          if (!answer.answer) {
            point += 25;
          }
          break;
        case BfQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual75PorcntEscola:
          if (answer.answer) {
            point += 25;
          }
          break;
        case BfQuizQuestionTypeEnum.crianca7AnosAcompanhamentoNutricional:
          if (answer.answer) {
            point += 25;
          }
          break;
        default:
      }
    }
    if (BfQuizQuestion
        .verifyCriancasComFrequenciaMaiorOuIgual60PorcntEscolaAndMoramCriancas6A18Anos(answers)) {
      point += 12.5;
    }
    quizValuesStream.value.pointsQuizOne = point;
    quizValuesStream.value.pointsQuizOnePercent = (point / 2);
    quizValuesStream.controller.add(quizValuesStream.value);
  }

  void setQuizTwoValue(List<BfQuizQuestion> answers) {
    double point = 0;
    for (var answer in answers) {
      switch (answer.type) {
        case BfQuizQuestionTypeEnum.inscreveuCadUnico:
          if (answer.answer) {
            point += 25;
          }
          break;
        case BfQuizQuestionTypeEnum.atualizouCadUnico:
          if (answer.answer) {
            point += 25;
          }
          break;
        case BfQuizQuestionTypeEnum.rendaPessoaMaior218:
          if (!answer.answer) {
            point += 25;
          }
          break;
        case BfQuizQuestionTypeEnum.alguemCasaInscritoMei:
          if (!answer.answer) {
            point += 25;
          }
          break;
        default:
      }
    }
    quizValuesStream.value.pointsQuizTwo = point;
    quizValuesStream.value.pointsQuizTwoPercent = (point / 2);
    quizValuesStream.controller.add(quizValuesStream.value);
  }

  void popUntilTestPage(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    push(context, const BfHomePage());
    push(context, const BfHasRightsHomePage());
    push(context, const BfHasRightsTestPage());
  }
}
