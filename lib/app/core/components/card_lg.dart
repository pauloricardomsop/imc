import 'package:benefits_brazil/app/core/components/label_double_column.dart';
import 'package:benefits_brazil/app/core/components/w.dart';
import 'package:flutter/material.dart';

class CardLg extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget image;

  const CardLg({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE3E2E2), width: 2)),
      child: Row(
        children: [
          image,
          const W(8),
          Expanded(child: LabelDoubleColumn(title, subtitle)),
        ],
      ),
    );
  }
}
