import 'package:flutter/material.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/theme/app_theme.dart';

class SectionHeaderSm extends StatelessWidget {
  final String title;
  final String desc;
  const SectionHeaderSm(this.title, this.desc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
        ),
        const H(16),
        Text(desc, style: AppTheme.text.normal.base(const Color(0xFF474747))),
        const H(16),
      ],
    );
  }
}
