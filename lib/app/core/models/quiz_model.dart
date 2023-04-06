class Quiz {
  double percentage;
  String title;
  String? subtitle;
  List<QuizOption> options;
  QuizOption? option;

  Quiz({
    required this.percentage,
    required this.title,
    required this.options,
    this.subtitle,
  });
}

class QuizOption {
  Function() onTap;
  String label;

  QuizOption({
    required this.onTap,
    required this.label,
  });
}
