// ignore_for_file: non_constant_identifier_names
import 'package:design_kit/design_kit.dart';

class SolucionandoDivergenciasQuiz {
  QuizOptionModel? qntdFilhos;

  int qntdFilhos0a6Controller = 0;
  int qntdFilhos7a18Controller = 0;
  int qntdGestantesController = 0;

  final double beneficioRendaCidadania;

  SolucionandoDivergenciasQuiz(this.beneficioRendaCidadania);

  // double get beneficioComplementar => beneficioRendaCidadania < 600 ? (600 - beneficioRendaCidadania) : 0.0;
  double get beneficioPrimeiraInfancia => qntdFilhos0a6Controller * 150;
  double get beneficioVariavelFamiliar =>
      (qntdFilhos7a18Controller + qntdGestantesController) * 50;
  double get totalBolsaFamilia =>
      beneficioRendaCidadania +
      // beneficioComplementar +
      beneficioPrimeiraInfancia +
      beneficioVariavelFamiliar;

  bool get possuiFilhos => qntdFilhos!.label == 'SIM';
  // bool get beneficioPrimeiraInfancia => qntdFilhos0a6Controller > 0;
  // bool get beneficioVariavelFamiliar => qntdFilhos7a18Controller > 0 || qntdGestantesController > 0;

  // int get valorPrimeiraInfancia => qntdFilhos0a6Controller * 150;
  // int get valorVariavelFamiliar => (qntdFilhos7a18Controller + qntdGestantesController) * 50 ;
  // int get valorFamiliar => valorPrimeiraInfancia + valorVariavelFamiliar;

  // SIM -> Tela de Extrato
  // NÃO -> Tela de Solucionando Divergencias

  // Beneficio de Renda e Cidadania : Valor da API
  // if(Beneficio de Renda e Cidadania < 600) Benefício Complementar : Valor faltante para chegar em 600

  // if(Filhos 0 a 6 anos) Benefício Primeira Infância: 150 * quantidade de filhos
  // if(Filhos 7 a 18 anos || Gestantes) Variavel Familiar : (qtde adolecentes * 50) + (qtde gravidas * 50)

  // TOTAL: Soma de Todos
}
