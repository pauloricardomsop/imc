import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/modules/quiz/quiz_model.dart';

enum QuizTypes {
  quantidadePessoas,
  quantidadeFilhos0a4,
  quantidadeFilhos4a6,
  quantidadeFilhos7a18,
  quantidadeGestantes,
}

class QuizController {
  static final QuizController _instance = QuizController._();

  QuizController._();

  factory QuizController() => _instance;

  AppStream<QuizModel> quizStream = AppStream<QuizModel>.seed(QuizModel());

  void updateQntdPeassoas(QuizTypes types, bool increment) {
    if (types == QuizTypes.quantidadePessoas) {
      (increment)
          ? quizStream.value.quantidadePessoas++
          : {
              if (quizStream.value.quantidadePessoas > 1)
                quizStream.value.quantidadePessoas--
            };
    }
    if (types == QuizTypes.quantidadeFilhos0a4) {
      (increment)
          ? quizStream.value.quantidadeFilhos0a4++
          : {
              if (quizStream.value.quantidadeFilhos0a4 > 1)
                quizStream.value.quantidadeFilhos0a4--
            };
    }
    if (types == QuizTypes.quantidadeFilhos4a6) {
      (increment)
          ? quizStream.value.quantidadeFilhos4a6++
          : {
              if (quizStream.value.quantidadeFilhos4a6 > 1)
                quizStream.value.quantidadeFilhos4a6--
            };
    }
    if (types == QuizTypes.quantidadeFilhos7a18) {
      (increment)
          ? quizStream.value.quantidadeFilhos7a18++
          : {
              if (quizStream.value.quantidadeFilhos7a18 > 1)
                quizStream.value.quantidadeFilhos7a18--
            };
    }
    if (types == QuizTypes.quantidadeGestantes) {
      (increment)
          ? quizStream.value.quantidadeGestantes++
          : {
              if (quizStream.value.quantidadeGestantes > 1)
                quizStream.value.quantidadeGestantes--
            };
    }
    quizStream.update();
  }

  String get titleController {
    if (quizStream.value.success) {
      return 'Parabéns';
    }
    if (quizStream.value.acimaDaRenda) {
      return 'Acima da renda \npermitida';
    }
    if (quizStream.value.pessoaJuridica) {
      return 'Pessoa Jurídica \nidentificada';
    }
    return 'Error';
  }

  String get subtitleController {
    if (quizStream.value.success) {
      return 'Você cumpre as regras principais do Novo Bolsa Família';
    }
    if (quizStream.value.acimaDaRenda) {
      return 'Infelizmente sua renda não se enquadra nas regras atuais do Novo Bolsa Família pois está acima do valor máximo de R\$ 218,00 por pessoa.';
    }
    if (quizStream.value.pessoaJuridica) {
      return 'Ninguém que mora em sua residência pode possuir um MEI ativo, pois isso desqualifica sua família de receber o benefício.';
    }
    return 'Error';
  }

  double get rendaFamiliarPorPessoa =>
      quizStream.value.rendaFamiliar.numberValue /
      quizStream.value.quantidadePessoas;

  void clean() {
    quizStream.add(QuizModel());
    quizStream.update();
  }
}
