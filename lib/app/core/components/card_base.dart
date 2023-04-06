import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svr/app/core/components/label_double_column.dart';
import 'package:svr/app/core/components/w.dart';

class CardBase extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? image;
  final Function() onTap;

  const CardBase(
      {Key? key, required this.title, required this.subtitle, this.image, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE3E2E2), width: 2)),
        child: Row(
          children: [
            if (image != null) image!,
            const W(8),
            Expanded(child: LabelDoubleColumnCard(title, subtitle)),
            Container(
              transform: Matrix4.translationValues(1, 0, 0),
              padding: const EdgeInsets.fromLTRB(9, 9, 4, 9),
              decoration: const BoxDecoration(
                  color: Color(0xFF1C44F9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24), bottomLeft: Radius.circular(24))),
              child: Transform.rotate(
                angle: -pi / 4,
                child: const Icon(
                  Icons.arrow_forward,
                  size: 26,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
