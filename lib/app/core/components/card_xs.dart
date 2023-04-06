import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/w.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:benefits_brazil/app/core/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardXs extends StatelessWidget {
  final Benefit benefit;
  final EdgeInsets? margin;

  const CardXs({
    Key? key,
    required this.benefit,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE3E2E2), width: 2)),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.grey[800]!,
              image: DecorationImage(image: CachedNetworkImageProvider(benefit.url), fit: BoxFit.cover),
              boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 2, spreadRadius: 1.5)],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const W(4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(benefit.name, style: AppTheme.text.extra.base(const Color(0xFF1B1C1C))),
              const H(2),
              Text(benefit.desc, style: AppTheme.text.normal.xs(const Color(0xFF474747))),
            ],
          ),
          const W(12),
        ],
      ),
    );
  }
}
