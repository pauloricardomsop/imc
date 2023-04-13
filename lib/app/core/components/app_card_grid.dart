import 'package:flutter/material.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/models/card_grid_model.dart';
import 'package:svr/app/core/theme/app_theme.dart';

class AppCardGrid extends StatelessWidget {
  final CardGridModel model;

  const AppCardGrid(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: model.onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE3E2E2)),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Icon(
              model.icon,
              color: const Color(0xFF1C44F9),
              size: 70,
            ),
            const H(4),
            Text(
              model.title,
              textAlign: TextAlign.center,
              style: AppTheme.text.semi.lg(const Color(0xFF1B1C1C)).copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
