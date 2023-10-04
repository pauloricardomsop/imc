import 'package:design_kit/design_kit.dart';

class ComoReceberQuizModel {
    QuizOptionModel? question01;
    QuizOptionModel? question02;
    QuizOptionModel? question03;

    bool get response01 => question01!.label == 'SIM';
    bool get response02 => question02!.label == 'SIM';
    bool get response03 => question03!.label == 'SIM';

    bool get isSuccess => response01 && response02 && response03;
    bool get isError => !response01 && !response02 && !response03;

}