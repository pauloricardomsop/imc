import 'package:design_kit/design_kit.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class QuizModel {
  int quantidadePessoas = 1;
  int quantidadeFilhos0a4 = 0;
  int quantidadeFilhos4a6 = 0;
  int quantidadeFilhos7a18 = 0;
  int quantidadeGestantes = 0;
  MoneyMaskedTextController rendaFamiliar = MoneyMaskedTextController();
  QuizOptionModel? possuiMei;
  QuizOptionModel? possuiCartaoVacinaFilhos0a6;
  QuizOptionModel? possuiFilhos4a18FrequentandoEscola;
  QuizOptionModel? possuiGestantePreNatalEmDia;
  QuizOptionModel? possuiCadastroAtualizado;

  bool get getPossuiMei => possuiMei!.label == 'SIM';
  bool get getPossuiCartaoVacinaFilhos0a6 =>
      possuiCartaoVacinaFilhos0a6!.label == 'SIM';
  bool get getPossuiFilhos4a18FrequentandoEscola =>
      possuiFilhos4a18FrequentandoEscola!.label == 'SIM';
  bool get getPossuiGestantePreNatalEmDia =>
      possuiGestantePreNatalEmDia!.label == 'SIM';
  bool get getPossuiCaastroAtualizado =>
      possuiCadastroAtualizado!.label == 'SIM';

  bool get getPossuiAlertas =>
      !getPossuiCartaoVacinaFilhos0a6 ||
      !getPossuiFilhos4a18FrequentandoEscola ||
      !getPossuiGestantePreNatalEmDia ||
      !getPossuiCaastroAtualizado;

  bool get success =>
      !getPossuiMei && (rendaFamiliar.numberValue / quantidadePessoas) <= 218;
  bool get acimaDaRenda =>
      !getPossuiMei && (rendaFamiliar.numberValue / quantidadePessoas) > 218;
  bool get pessoaJuridica => getPossuiMei;

  double get estimacaoBeneficio =>
      quantidadeFilhos0a4 * 150 +
      quantidadeFilhos4a6 * 150 +
      quantidadeFilhos7a18 * 50 +
      quantidadeGestantes * 50 +
      600;

  double get rendaFamiliarPorPessoa =>
      rendaFamiliar.numberValue / quantidadePessoas;
}
