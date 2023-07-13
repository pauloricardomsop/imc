
import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/modules/como_receber/como_receber_model.dart';

class ComoReceberController {
  static final ComoReceberController _instance = ComoReceberController._();

  ComoReceberController._();

  factory ComoReceberController() => _instance;

  final comoReceberQuizStream = AppStream<ComoReceberQuiz>();
}
