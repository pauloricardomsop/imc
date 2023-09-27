import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/modules/calculadora_valores/calculadora_valores_model.dart';

enum CalcTypes {
  quantidadeFilhos0a6,
  quantidadeGestantes,
  quantidadeFilhos7a18
}

class CalculadoraValoresController {
  static final CalculadoraValoresController _instance =
      CalculadoraValoresController._();

  CalculadoraValoresController._();

  factory CalculadoraValoresController() => _instance;

  AppStream<CalculadoraValoresModel> calValoresStream =
      AppStream<CalculadoraValoresModel>.seed(CalculadoraValoresModel());

  void updateQntdFilhos(CalcTypes type, bool increment) {
    if (type == CalcTypes.quantidadeFilhos0a6) {
      (increment)
          ? calValoresStream.value.quantidadeFilhos0a6++
          : {
              if (calValoresStream.value.quantidadeFilhos0a6 > 0)
                calValoresStream.value.quantidadeFilhos0a6--
            };
    }
    if (type == CalcTypes.quantidadeGestantes) {
      (increment)
          ? calValoresStream.value.quantidadeGestantes++
          : {
              if (calValoresStream.value.quantidadeGestantes > 0)
                calValoresStream.value.quantidadeGestantes--
            };
    }
    if (type == CalcTypes.quantidadeFilhos7a18) {
      (increment)
          ? calValoresStream.value.quantidadeFilhos7a18++
          : {
              if (calValoresStream.value.quantidadeFilhos7a18 > 0)
                calValoresStream.value.quantidadeFilhos7a18--
            };
    }
    calValoresStream.update();
  }

  double get rentaMedia =>
      calValoresStream.value.quantidadeFilhos0a6 * 150 +
      calValoresStream.value.quantidadeGestantes * 50 +
      calValoresStream.value.quantidadeFilhos7a18 * 50 +
      600;

  void dispose() {
    calValoresStream.add(CalculadoraValoresModel());
  }
}
