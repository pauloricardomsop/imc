// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:benefits_brazil/app/core/models/quiz_model.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/bf/has_rights/bf_has_rights_controller.dart';
import 'package:benefits_brazil/app/modules/bf/has_rights/ui/bf_has_rights_quiz_page.dart';
import 'package:flutter/cupertino.dart';

enum BfQuizQuestionTypeEnum {
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

class BfHasRightsQuizValues {
  double? pointsQuizOne;
  double? pointsQuizOnePercent;
  double? pointsQuizTwo;
  double? pointsQuizTwoPercent;
}

class BfQuizQuestion {
  final BfQuizQuestionTypeEnum type;
  final double points;
  final bool answer;
  BfQuizQuestion(this.type, this.points, this.answer);

  static bool verifyShowCrianca7AnosAcompanhamentoNutricional(List<BfQuizQuestion> answers) {
    final question1 =
        answers.where((e) => e.type == BfQuizQuestionTypeEnum.preNataisEmDia).toList();
    final question2 = answers.singleWhere((e) => e.type == BfQuizQuestionTypeEnum.moramCriacas0a5);

    return question2.answer && (question1.isEmpty ? false : question1.first.answer);
  }

  static bool verifyCriancasComFrequenciaMaiorOuIgual60PorcntEscolaAndMoramCriancas6A18Anos(
      List<BfQuizQuestion> answers) {
    final question1 = answers
        .where(
            (e) => e.type == BfQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual60PorcntEscola)
        .toList();
    final question2 =
        answers.singleWhere((e) => e.type == BfQuizQuestionTypeEnum.moramCriancas6A18Anos);

    return question2.answer == false &&
        (question1.isEmpty ? false : question1.first.answer == false);
  }
}

class BfHasRightsQuiz {
  static final BfHasRightsController _quizController = BfHasRightsController();

  static BfHasRightsQuizPage quizSaudeEducacao(BuildContext context) =>
      _vacinasAtualizadas(context, []);

  static BfHasRightsQuizPage _vacinasAtualizadas(
          BuildContext context, List<BfQuizQuestion> answers) =>
      BfHasRightsQuizPage(Quiz(
          percentage: 20,
          title: 'Todos em sua casa, estão com as vacinas atualizadas?',
          subtitle:
              'Responda sim, caso todos tenham tomado as vacinas do calendário nacional de vacinação.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.vacinasAtualizadas, 12.5, true));
                push(context, _moramPesosaGestante(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.vacinasAtualizadas, 0, false));
                push(context, _moramPesosaGestante(context, answers));
              },
              label: 'Não',
            ),
          ]));

  static BfHasRightsQuizPage _moramPesosaGestante(
          BuildContext context, List<BfQuizQuestion> answers) =>
      BfHasRightsQuizPage(Quiz(
          percentage: 40,
          title: 'Em sua casa, moram pessoas gestantes?',
          subtitle: 'Responda sim, caso uma ou mais pessoas estejam esperando bebês em sua casa.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.moramPesosaGestante, 0, true));
                push(context, _preNataisEmDia(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.moramPesosaGestante, 25, false));
                push(context, _moramCriacas0a5(context, answers));
              },
              label: 'Não',
            ),
          ]));

  static BfHasRightsQuizPage _preNataisEmDia(BuildContext context, List<BfQuizQuestion> answers) =>
      BfHasRightsQuizPage(Quiz(
          percentage: 40,
          title: 'Os pré-natais das gestantes estão em dias?',
          subtitle:
              'Responda sim, caso a gestante esteja sendo acompanhada por um profissional da saúde durante a gravidez.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.preNataisEmDia, 25, true));
                push(context, _moramCriacas0a5(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.preNataisEmDia, 0, false));
                push(context, _moramCriacas0a5(context, answers));
              },
              label: 'Não',
            ),
          ]));

  static BfHasRightsQuizPage _moramCriacas0a5(BuildContext context, List<BfQuizQuestion> answers) =>
      BfHasRightsQuizPage(Quiz(
          percentage: 60,
          title: 'Em sua casa, moram crianças de 0 à 5 anos?',
          subtitle: 'Responda sim, caso em sua casa more uma ou mais crianças de 0 à 5 anos.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.moramCriacas0a5, 0, true));
                push(context, _criancasComFrequenciaMaiorOuIgual60PorcntEscola(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.moramCriacas0a5, 25, false));
                push(context, _moramCriancas6A18Anos(context, answers));
              },
              label: 'Não',
            ),
          ]));

  static BfHasRightsQuizPage _criancasComFrequenciaMaiorOuIgual60PorcntEscola(
          BuildContext context, List<BfQuizQuestion> answers) =>
      BfHasRightsQuizPage(Quiz(
          percentage: 60,
          title: 'As crianças de 4 à 5 anos estão com frequência escolar igual ou superior a 60%?',
          subtitle:
              'Caso a criança ainda não tenha atingido os 4 anos, e não esteja estudando, responda Ainda não completou 4 anos.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(
                    BfQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual60PorcntEscola,
                    25,
                    true));
                push(context, _moramCriancas6A18Anos(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(
                    BfQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual60PorcntEscola,
                    0,
                    false));
                push(context, _moramCriancas6A18Anos(context, answers));
              },
              label: 'Não',
            ),
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(
                    BfQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual60PorcntEscola,
                    25,
                    true));
                push(context, _moramCriancas6A18Anos(context, answers));
              },
              label: 'Ainda não completou',
            ),
          ]));

  static BfHasRightsQuizPage _moramCriancas6A18Anos(
          BuildContext context, List<BfQuizQuestion> answers) =>
      BfHasRightsQuizPage(Quiz(
          percentage: 80,
          title: 'Em sua casa, moram crianças de 6 à 18 anos?',
          subtitle: 'Responda sim, caso em sua casa more uma ou mais crianças de 6 à 18 anos.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.moramCriancas6A18Anos, 0, true));
                push(context, _criancasComFrequenciaMaiorOuIgual75PorcntEscola(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers
                    .add(BfQuizQuestion(BfQuizQuestionTypeEnum.moramCriancas6A18Anos, 25, false));
                if (BfQuizQuestion.verifyShowCrianca7AnosAcompanhamentoNutricional(answers)) {
                  push(context, _crianca7AnosAcompanhamentoNutricional(context, answers));
                } else {
                  _quizController.setQuizOneValue(answers);
                  _quizController.popUntilTestPage(context);
                }
              },
              label: 'Não',
            ),
          ]));

  static BfHasRightsQuizPage _criancasComFrequenciaMaiorOuIgual75PorcntEscola(
          BuildContext context, List<BfQuizQuestion> answers) =>
      BfHasRightsQuizPage(Quiz(
          percentage: 80,
          title: 'As crianças de 6 à 18 anos estão com frequência escolar igual ou superior a 75%?',
          options: [
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(
                    BfQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual75PorcntEscola,
                    25,
                    true));
                if (BfQuizQuestion.verifyShowCrianca7AnosAcompanhamentoNutricional(answers)) {
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
                answers.add(BfQuizQuestion(
                    BfQuizQuestionTypeEnum.criancasComFrequenciaMaiorOuIgual75PorcntEscola,
                    0,
                    false));
                if (BfQuizQuestion.verifyShowCrianca7AnosAcompanhamentoNutricional(answers)) {
                  push(context, _crianca7AnosAcompanhamentoNutricional(context, answers));
                } else {
                  _quizController.setQuizOneValue(answers);
                  _quizController.popUntilTestPage(context);
                }
              },
              label: 'Não',
            ),
          ]));

  static BfHasRightsQuizPage _crianca7AnosAcompanhamentoNutricional(
          BuildContext context, List<BfQuizQuestion> answers) =>
      BfHasRightsQuizPage(Quiz(
          percentage: 100,
          title:
              'As crianças de até 7 anos, estão com o acompanhamento de estado nutricional atualizado?',
          subtitle:
              'Responda sim caso as crianças estejam fazendo acompanhamento nutricional com um profissional da saúde.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(
                    BfQuizQuestionTypeEnum.crianca7AnosAcompanhamentoNutricional, 12.5, true));
                _quizController.setQuizOneValue(answers);
                _quizController.popUntilTestPage(context);
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(
                    BfQuizQuestionTypeEnum.crianca7AnosAcompanhamentoNutricional, 0, false));
                _quizController.setQuizOneValue(answers);
                _quizController.popUntilTestPage(context);
              },
              label: 'Não',
            ),
          ]));

  static BfHasRightsQuizPage quizRendaFamiliar(BuildContext context) =>
      _inscreveuCadUnico(context, []);

  static BfHasRightsQuizPage _inscreveuCadUnico(
          BuildContext context, List<BfQuizQuestion> answers) =>
      BfHasRightsQuizPage(Quiz(
          percentage: 50,
          title: 'Você já se inscreveu no Cadastro Único?',
          subtitle:
              'Se você já foi beneficiário do Auxílio Brasil, Bolsa Família ou Auxílio Gás. Você pode já estar cadastrado no CadÚnico.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.inscreveuCadUnico, 25, true));
                push(context, _atualizouCadUnico(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.inscreveuCadUnico, 0, false));
                push(context, _rendaPessoaMaior218(context, answers));
              },
              label: 'Não',
            ),
          ]));

  static BfHasRightsQuizPage _atualizouCadUnico(
          BuildContext context, List<BfQuizQuestion> answers) =>
      BfHasRightsQuizPage(Quiz(
          percentage: 50,
          title: 'Você atualizou seu Cadastro Único nos últimos 24 meses?',
          subtitle:
              'Caso não tenha atualizado seu cadastro, busque um CRAS mais próximo de sua casa, e atualize seu cadastro.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.atualizouCadUnico, 25, true));
                push(context, _rendaPessoaMaior218(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.atualizouCadUnico, 0, false));
                push(context, _rendaPessoaMaior218(context, answers));
              },
              label: 'Não',
            ),
          ]));

  static BfHasRightsQuizPage _rendaPessoaMaior218(
          BuildContext context, List<BfQuizQuestion> answers) =>
      BfHasRightsQuizPage(Quiz(
          percentage: 75,
          title: 'Em sua casa, a renda por pessoa é maior que R\$218,00?',
          subtitle:
              'Exemplo: Se na minha casa, moram 5 pessoas e só uma pessoa recebe salário de R\$1.000,00. Então a renda por pessoa é de R\$200,00. ',
          options: [
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.rendaPessoaMaior218, 0, true));
                push(context, _alguemCasaInscritoMei(context, answers));
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.rendaPessoaMaior218, 25, false));
                push(context, _alguemCasaInscritoMei(context, answers));
              },
              label: 'Não',
            ),
          ]));

  static BfHasRightsQuizPage _alguemCasaInscritoMei(
          BuildContext context, List<BfQuizQuestion> answers) =>
      BfHasRightsQuizPage(Quiz(
          percentage: 100,
          title: 'Alguém na sua casa está inscrito como MEI?',
          subtitle: 'O Micro Empreendedor Individual, tem menos chances de ser aprovado.',
          options: [
            QuizOption(
              onTap: () {
                answers.add(BfQuizQuestion(BfQuizQuestionTypeEnum.alguemCasaInscritoMei, 0, true));
                _quizController.setQuizTwoValue(answers);
                _quizController.popUntilTestPage(context);
              },
              label: 'Sim',
            ),
            QuizOption(
              onTap: () {
                answers
                    .add(BfQuizQuestion(BfQuizQuestionTypeEnum.alguemCasaInscritoMei, 25, false));
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
