import 'package:flutter/cupertino.dart';

import '../theme/app_theme.dart';

class AppCardPurple extends StatelessWidget {
  final String text;

  const AppCardPurple(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration:
            BoxDecoration(color: const Color(0xFFDDE0FF), borderRadius: BorderRadius.circular(16)),
        child: Text(
          text,
          style: AppTheme.text.normal.base(const Color(0xFF000C61)),
        ));
  }
}
