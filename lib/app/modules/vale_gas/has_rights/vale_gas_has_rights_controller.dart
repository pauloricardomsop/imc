import 'package:benefits_brazil/app/core/models/app_stream.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/vale_gas/vale_gas_home_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/has_rights/ui/vale_gas_has_rights_home_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/has_rights/ui/vale_gas_has_rights_test_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/has_rights/vale_gas_has_rights_model.dart';
import 'package:flutter/material.dart';

class ValeGasHasRightsController {
  static final ValeGasHasRightsController _valeGasQuizController = ValeGasHasRightsController._();

  ValeGasHasRightsController._();

  factory ValeGasHasRightsController() => _valeGasQuizController;

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  BuildContext get context => key.currentState!.context;

  AppStream<ValeGasHasRightsQuizValues> quizValuesStream =
      AppStream<ValeGasHasRightsQuizValues>.seed(ValeGasHasRightsQuizValues());

  void setQuizOneValue(List<ValeGasQuizQuestion> answers) {
    double point = 0;
    for (var answer in answers) {
      switch (answer.type) {
        case ValeGasQuizQuestionTypeEnum.vacinasAtualizadas:
          if (answer.answer) {
            point += 12.5;
          }
          break;
        case ValeGasQuizQuestionTypeEnum.moramPesosaGestante:
          if (!answer.answer) {
            point += 25;
          }
          break;
        case ValeGasQuizQuestionTypeEnum.preNataisEmDia:
          if (answer.answer) {
            point += 25;
          }
          break;
        case ValeGasQuizQuestionTypeEnum.moramCriacas0a5:
          if (!answer.answer) {
            point += 25;
          }
          break;
        case ValeGasQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual60PorcntEscola:
          if (answer.answer) {
            point += 25;
          }
          break;
        case ValeGasQuizQuestionTypeEnum.moramCriancas6A18Anos:
          if (!answer.answer) {
            point += 25;
          }
          break;
        case ValeGasQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual75PorcntEscola:
          if (answer.answer) {
            point += 25;
          }
          break;
        case ValeGasQuizQuestionTypeEnum.crianca7AnosAcompanhamentoNutricional:
          if (answer.answer) {
            point += 25;
          }
          break;
        default:
      }
    }
    if (ValeGasQuizQuestion
        .verifyCriancasComFrequenciaMaiorOuIgual60PorcntEscolaAndMoramCriancas6A18Anos(answers)) {
      point += 12.5;
    }
    quizValuesStream.value.pointsQuizOne = point;
    quizValuesStream.value.pointsQuizOnePercent = (point / 2);
    quizValuesStream.controller.add(quizValuesStream.value);
  }

  void setQuizTwoValue(List<ValeGasQuizQuestion> answers) {
    double point = 0;
    for (var answer in answers) {
      switch (answer.type) {
        case ValeGasQuizQuestionTypeEnum.inscreveuCadUnico:
          if (answer.answer) {
            point += 25;
          }
          break;
        case ValeGasQuizQuestionTypeEnum.atualizouCadUnico:
          if (answer.answer) {
            point += 25;
          }
          break;
        case ValeGasQuizQuestionTypeEnum.rendaPessoaMaior218:
          if (!answer.answer) {
            point += 25;
          }
          break;
        case ValeGasQuizQuestionTypeEnum.alguemCasaInscritoMei:
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
    push(context, const ValeGasHomePage());
    push(context, const ValeGasHasRightsHomePage());
    push(context, const ValeGasHasRightsTestPage());
  }
}
