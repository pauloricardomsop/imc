import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/modules/calculadora_renda/calculadora_renda_model.dart';
import 'package:intl/intl.dart';

class CalculadoraRendaController {
  static final CalculadoraRendaController _instance =
      CalculadoraRendaController._();

  CalculadoraRendaController._();

  factory CalculadoraRendaController() => _instance;

  AppStream<CalculadoraRendaModel> calcRendaStream =
      AppStream<CalculadoraRendaModel>.seed(CalculadoraRendaModel());

  String get rentaMedia => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
      .format(calcRendaStream.value.rendaFamiliar.numberValue /
          calcRendaStream.value.quantidadePessoas);

  void updateQntd(bool increment) {
    (increment)
        ? calcRendaStream.value.quantidadePessoas++
        : {
            if (calcRendaStream.value.quantidadePessoas > 1)
              calcRendaStream.value.quantidadePessoas--
          };
    calcRendaStream.update();
  }

  void dispose() {
    calcRendaStream.add(CalculadoraRendaModel());
  }
}
