import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/modules/solucionando_divergencias/solucionando_divergencias_model.dart';

enum SolucionandoKeys {
  qntdFilhos0a6,
  qntdFilhos7a18,
  qntdGestantes,
}

class SolucionandoDivergenciasController {
  static final SolucionandoDivergenciasController _instance =
      SolucionandoDivergenciasController._();

  SolucionandoDivergenciasController._();

  factory SolucionandoDivergenciasController() => _instance;

  AppStream<SolucionandoDivergenciasQuiz> quizStream =
      AppStream<SolucionandoDivergenciasQuiz>();

  void updateQntd(SolucionandoKeys key, bool isIncrement) {
    switch (key) {
      case SolucionandoKeys.qntdFilhos0a6:
        (isIncrement)
            ? quizStream.value.qntdFilhos0a6Controller++
            : {
                if (quizStream.value.qntdFilhos0a6Controller > 0)
                  quizStream.value.qntdFilhos0a6Controller--
              };
        break;
      case SolucionandoKeys.qntdFilhos7a18:
        (isIncrement)
            ? quizStream.value.qntdFilhos7a18Controller++
            : {
                if (quizStream.value.qntdFilhos7a18Controller > 0)
                  quizStream.value.qntdFilhos7a18Controller--
              };
        break;
      case SolucionandoKeys.qntdGestantes:
        (isIncrement)
            ? quizStream.value.qntdGestantesController++
            : {
                if (quizStream.value.qntdGestantesController > 0)
                  quizStream.value.qntdGestantesController--
              };
        break;
    }
    quizStream.update();
  }
}
