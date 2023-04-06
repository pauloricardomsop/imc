import 'package:flutter/cupertino.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/theme/app_theme.dart';

class LabelDoubleColumn extends StatelessWidget {
  final String top;
  final String bottom;

  const LabelDoubleColumn(this.top, this.bottom, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(top, style: AppTheme.text.normal.base(const Color(0xFF777777))),
        const H(2),
        Text(bottom, style: AppTheme.text.extra.xl3(const Color(0xFF474747))),
      ],
    );
  }
}

class LabelDoubleDescriptionColumn extends StatelessWidget {
  final String top;
  final String bottom;

  const LabelDoubleDescriptionColumn(this.top, this.bottom, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(top, style: AppTheme.text.semi.lg(const Color(0xFF1B1C1C))),
        const H(2),
        Text(bottom, style: AppTheme.text.normal.sm(const Color(0xFF474747))),
      ],
    );
  }
}

class LabelDoubleColumnCard extends StatelessWidget {
  final String top;
  final String bottom;

  const LabelDoubleColumnCard(this.top, this.bottom, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(top, style: AppTheme.text.normal.xs(const Color(0xFF777777))),
        const H(2),
        Text(bottom, style: AppTheme.text.extra.xl(const Color(0xFF474747))),
      ],
    );
  }
}
