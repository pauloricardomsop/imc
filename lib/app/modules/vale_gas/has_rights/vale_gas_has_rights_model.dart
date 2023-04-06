// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:benefits_brazil/app/core/models/quiz_model.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/vale_gas/has_rights/ui/vale_gas_has_rights_quiz_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/has_rights/vale_gas_has_rights_controller.dart';
import 'package:flutter/cupertino.dart';

enum ValeGasQuizQuestionTypeEnum {
  vacinasAtualizadas,
  moramPesosaGestante,
  preNataisEmDia,
  moramCriacas0a5,
  criancasComFrequenciaMaiorOuIgual60PorcntEscola,
  moramCriancas6A18Anos,
  criancasComFrequenciaMaiorOuIgual75PorcntEscola,
  crianca7AnosAcompanhamentoNutricional,
  inscreveuCadUnico,
  atualizouCadUnico,
  rendaPessoaMaior218,
  alguemCasaInscritoMei,
}

class ValeGasHasRightsQuizValues {
  double? pointsQuizOne;
  double? pointsQuizOnePercent;
  double? pointsQuizTwo;
  double? pointsQuizTwoPercent;
}

class ValeGasQuizQuestion {
  final ValeGasQuizQuestionTypeEnum type;
  final double points;
  final bool answer;
  ValeGasQuizQuestion(this.type, this.points, this.answer);

  static bool verifyShowCrianca7AnosAcompanhamentoNutricional(List<ValeGasQuizQuestion> answers) {
    final question1 =
        answers.where((e) => e.type == ValeGasQuizQuestionTypeEnum.preNataisEmDia).toList();
    final question2 =
        answers.singleWhere((e) => e.type == ValeGasQuizQuestionTypeEnum.moramCriacas0a5);

    return question2.answer && (question1.isEmpty ? false : question1.first.answer);
  }

  static bool verifyCriancasComFrequenciaMaiorOuIgual60PorcntEscolaAndMoramCriancas6A18Anos(
      List<ValeGasQuizQuestion> answers) {
    final question1 = answers
        .where((e) =>
            e.type == ValeGasQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual60PorcntEscola)
        .toList();
    final question2 =
        answers.singleWhere((e) => e.type == ValeGasQuizQuestionTypeEnum.moramCriancas6A18Anos);

    return question2.answer == false &&
        (question1.isEmpty ? false : question1.first.answer == false);
  }
}

class ValeGasHasRightsQuiz {
  static final ValeGasHasRightsController _quizController = ValeGasHasRightsController();

  static ValeGasHasRightsQuizPage quizSaudeEducacao(BuildContext context) =>
      _vacinasAtualizadas(context, []);

  static ValeGasHasRightsQuizPage _vacinasAtualizadas(
          BuildContext context, List<ValeGasQuizQuestion> answers) =>
      ValeGasHasRightsQuizPage(Quiz(
          percentage: 20,
          title: 'Todos em sua casa, estão com as vacinas atualizadas?',
          subtitle:
              'Responda sim, caso todos tenham tomado as vacinas do calendário nacional de vacinação.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(ValeGasQuizQuestion(
                    ValeGasQuizQuestionTypeEnum.vacinasAtualizadas, 12.5, true));
                push(context, _moramPesosaGestante(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(
                    ValeGasQuizQuestion(ValeGasQuizQuestionTypeEnum.vacinasAtualizadas, 0, false));
                push(context, _moramPesosaGestante(context, answers));
              },
              label: 'Não',
            ),
          ]));

  static ValeGasHasRightsQuizPage _moramPesosaGestante(
          BuildContext context, List<ValeGasQuizQuestion> answers) =>
      ValeGasHasRightsQuizPage(Quiz(
          percentage: 40,
          title: 'Em sua casa, moram pessoas gestantes?',
          subtitle: 'Responda sim, caso uma ou mais pessoas estejam esperando bebês em sua casa.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(
                    ValeGasQuizQuestion(ValeGasQuizQuestionTypeEnum.moramPesosaGestante, 0, true));
                push(context, _preNataisEmDia(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(ValeGasQuizQuestion(
                    ValeGasQuizQuestionTypeEnum.moramPesosaGestante, 25, false));
                push(context, _moramCriacas0a5(context, answers));
              },
              label: 'Não',
            ),
          ]));

  static ValeGasHasRightsQuizPage _preNataisEmDia(
          BuildContext context, List<ValeGasQuizQuestion> answers) =>
      ValeGasHasRightsQuizPage(Quiz(
          percentage: 40,
          title: 'Os pré-natais das gestantes estão em dias?',
          subtitle:
              'Responda sim, caso a gestante esteja sendo acompanhada por um profissional da saúde durante a gravidez.',
          options: [
            QuizOption(
              onTap: () {
                answers
                    .add(ValeGasQuizQuestion(ValeGasQuizQuestionTypeEnum.preNataisEmDia, 25, true));
                push(context, _moramCriacas0a5(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers
                    .add(ValeGasQuizQuestion(ValeGasQuizQuestionTypeEnum.preNataisEmDia, 0, false));
                push(context, _moramCriacas0a5(context, answers));
              },
              label: 'Não',
            ),
          ]));

  static ValeGasHasRightsQuizPage _moramCriacas0a5(
          BuildContext context, List<ValeGasQuizQuestion> answers) =>
      ValeGasHasRightsQuizPage(Quiz(
          percentage: 60,
          title: 'Em sua casa, moram crianças de 0 à 5 anos?',
          subtitle: 'Responda sim, caso em sua casa more uma ou mais crianças de 0 à 5 anos.',
          options: [
            QuizOption(
              onTap: () {
                answers
                    .add(ValeGasQuizQuestion(ValeGasQuizQuestionTypeEnum.moramCriacas0a5, 0, true));
                push(context, _criancasComFrequenciaMaiorOuIgual60PorcntEscola(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(
                    ValeGasQuizQuestion(ValeGasQuizQuestionTypeEnum.moramCriacas0a5, 25, false));
                push(context, _moramCriancas6A18Anos(context, answers));
              },
              label: 'Não',
            ),
          ]));

  static ValeGasHasRightsQuizPage _criancasComFrequenciaMaiorOuIgual60PorcntEscola(
          BuildContext context, List<ValeGasQuizQuestion> answers) =>
      ValeGasHasRightsQuizPage(Quiz(
          percentage: 60,
          title: 'As crianças de 4 à 5 anos estão com frequência escolar igual ou superior a 60%?',
          subtitle:
              'Caso a criança ainda não tenha atingido os 4 anos, e não esteja estudando, responda Ainda não completou 4 anos.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(ValeGasQuizQuestion(
                    ValeGasQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual60PorcntEscola,
                    25,
                    true));
                push(context, _moramCriancas6A18Anos(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(ValeGasQuizQuestion(
                    ValeGasQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual60PorcntEscola,
                    0,
                    false));
                push(context, _moramCriancas6A18Anos(context, answers));
              },
              label: 'Não',
            ),
            QuizOption(
              onTap: () {
                answers.add(ValeGasQuizQuestion(
                    ValeGasQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual60PorcntEscola,
                    25,
                    true));
                push(context, _moramCriancas6A18Anos(context, answers));
              },
              label: 'Ainda não completou',
            ),
          ]));

  static ValeGasHasRightsQuizPage _moramCriancas6A18Anos(
          BuildContext context, List<ValeGasQuizQuestion> answers) =>
      ValeGasHasRightsQuizPage(Quiz(
          percentage: 80,
          title: 'Em sua casa, moram crianças de 6 à 18 anos?',
          subtitle: 'Responda sim, caso em sua casa more uma ou mais crianças de 6 à 18 anos.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(ValeGasQuizQuestion(
                    ValeGasQuizQuestionTypeEnum.moramCriancas6A18Anos, 0, true));
                push(context, _criancasComFrequenciaMaiorOuIgual75PorcntEscola(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(ValeGasQuizQuestion(
                    ValeGasQuizQuestionTypeEnum.moramCriancas6A18Anos, 25, false));
                if (ValeGasQuizQuestion.verifyShowCrianca7AnosAcompanhamentoNutricional(answers)) {
                  push(context, _crianca7AnosAcompanhamentoNutricional(context, answers));
                } else {
                  _quizController.setQuizOneValue(answers);
                  _quizController.popUntilTestPage(context);
                }
              },
              label: 'Não',
            ),
          ]));

  static ValeGasHasRightsQuizPage _criancasComFrequenciaMaiorOuIgual75PorcntEscola(
          BuildContext context, List<ValeGasQuizQuestion> answers) =>
      ValeGasHasRightsQuizPage(Quiz(
          percentage: 80,
          title: 'As crianças de 6 à 18 anos estão com frequência escolar igual ou superior a 75%?',
          options: [
            QuizOption(
              onTap: () {
                answers.add(ValeGasQuizQuestion(
                    ValeGasQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual75PorcntEscola,
                    25,
                    true));
                if (ValeGasQuizQuestion.verifyShowCrianca7AnosAcompanhamentoNutricional(answers)) {
                  push(context, _crianca7AnosAcompanhamentoNutricional(context, answers));
                } else {
                  _quizController.setQuizOneValue(answers);
                  _quizController.popUntilTestPage(context);
                }
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(ValeGasQuizQuestion(
                    ValeGasQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual75PorcntEscola,
                    0,
                    false));
                if (ValeGasQuizQuestion.verifyShowCrianca7AnosAcompanhamentoNutricional(answers)) {
                  push(context, _crianca7AnosAcompanhamentoNutricional(context, answers));
                } else {
                  _quizController.setQuizOneValue(answers);
                  _quizController.popUntilTestPage(context);
                }
              },
              label: 'Não',
            ),
          ]));

  static ValeGasHasRightsQuizPage _crianca7AnosAcompanhamentoNutricional(
          BuildContext context, List<ValeGasQuizQuestion> answers) =>
      ValeGasHasRightsQuizPage(Quiz(
          percentage: 100,
          title:
              'As crianças de até 7 anos, estão com o acompanhamento de estado nutricional atualizado?',
          subtitle:
              'Responda sim caso as crianças estejam fazendo acompanhamento nutricional com um profissional da saúde.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(ValeGasQuizQuestion(
                    ValeGasQuizQuestionTypeEnum.crianca7AnosAcompanhamentoNutricional, 12.5, true));
                _quizController.setQuizOneValue(answers);
                _quizController.popUntilTestPage(context);
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(ValeGasQuizQuestion(
                    ValeGasQuizQuestionTypeEnum.crianca7AnosAcompanhamentoNutricional, 0, false));
                _quizController.setQuizOneValue(answers);
                _quizController.popUntilTestPage(context);
              },
              label: 'Não',
            ),
          ]));

  static ValeGasHasRightsQuizPage quizRendaFamiliar(BuildContext context) =>
      _inscreveuCadUnico(context, []);

  static ValeGasHasRightsQuizPage _inscreveuCadUnico(
          BuildContext context, List<ValeGasQuizQuestion> answers) =>
      ValeGasHasRightsQuizPage(Quiz(
          percentage: 50,
          title: 'Você já se inscreveu no Cadastro Único?',
          subtitle:
              'Se você já foi beneficiário do Auxílio Brasil, Bolsa Família ou Auxílio Gás. Você pode já estar cadastrado no CadÚnico.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(
                    ValeGasQuizQuestion(ValeGasQuizQuestionTypeEnum.inscreveuCadUnico, 25, true));
                push(context, _atualizouCadUnico(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(
                    ValeGasQuizQuestion(ValeGasQuizQuestionTypeEnum.inscreveuCadUnico, 0, false));
                push(context, _rendaPessoaMaior218(context, answers));
              },
              label: 'Não',
            ),
          ]));

  static ValeGasHasRightsQuizPage _atualizouCadUnico(
          BuildContext context, List<ValeGasQuizQuestion> answers) =>
      ValeGasHasRightsQuizPage(Quiz(
          percentage: 50,
          title: 'Você atualizou seu Cadastro Único nos últimos 24 meses?',
          subtitle:
              'Caso não tenha atualizado seu cadastro, busque um CRAS mais próximo de sua casa, e atualize seu cadastro.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(
                    ValeGasQuizQuestion(ValeGasQuizQuestionTypeEnum.atualizouCadUnico, 25, true));
                push(context, _rendaPessoaMaior218(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(
                    ValeGasQuizQuestion(ValeGasQuizQuestionTypeEnum.atualizouCadUnico, 0, false));
                push(context, _rendaPessoaMaior218(context, answers));
              },
              label: 'Não',
            ),
          ]));

  static ValeGasHasRightsQuizPage _rendaPessoaMaior218(
          BuildContext context, List<ValeGasQuizQuestion> answers) =>
      ValeGasHasRightsQuizPage(Quiz(
          percentage: 75,
          title: 'Em sua casa, a renda por pessoa é maior que R\$218,00?',
          subtitle:
              'Exemplo: Se na minha casa, moram 5 pessoas e só uma pessoa recebe salário de R\$1.000,00. Então a renda por pessoa é de R\$200,00. ',
          options: [
            QuizOption(
              onTap: () {
                answers.add(
                    ValeGasQuizQuestion(ValeGasQuizQuestionTypeEnum.rendaPessoaMaior218, 0, true));
                push(context, _alguemCasaInscritoMei(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(ValeGasQuizQuestion(
                    ValeGasQuizQuestionTypeEnum.rendaPessoaMaior218, 25, false));
                push(context, _alguemCasaInscritoMei(context, answers));
              },
              label: 'Não',
            ),
          ]));

  static ValeGasHasRightsQuizPage _alguemCasaInscritoMei(
          BuildContext context, List<ValeGasQuizQuestion> answers) =>
      ValeGasHasRightsQuizPage(Quiz(
          percentage: 100,
          title: 'Alguém na sua casa está inscrito como MEI?',
          subtitle: 'O Micro Empreendedor Individual, tem menos chances de ser aprovado.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(ValeGasQuizQuestion(
                    ValeGasQuizQuestionTypeEnum.alguemCasaInscritoMei, 0, true));
                _quizController.setQuizTwoValue(answers);
                _quizController.popUntilTestPage(context);
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(ValeGasQuizQuestion(
                    ValeGasQuizQuestionTypeEnum.alguemCasaInscritoMei, 25, false));
                _quizController.setQuizTwoValue(answers);
                _quizController.popUntilTestPage(context);
              },
              label: 'Não',
            ),
          ]));
}

class QuizPoint {
  double point;
  QuizPoint(
    this.point,
  );
}
