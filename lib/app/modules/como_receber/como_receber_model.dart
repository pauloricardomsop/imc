import 'package:svr/app/core/components/quiz_option_widget.dart';

class ComoReceberQuiz {
  QuizOptionModel? cpfData;
  QuizOptionModel? contaGov;
  QuizOptionModel? chavePix;

  bool get possuiCpfData => cpfData!.label == 'Sim';
  bool get possuiContaGov => contaGov!.label == 'Sim';
  bool get possuiChavePix => chavePix!.label == 'Sim';

  String get titleResult =>
      possuiCpfData && possuiContaGov && possuiChavePix ? 'Parabéns!' : 'Ajustes necessários.';

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
}
