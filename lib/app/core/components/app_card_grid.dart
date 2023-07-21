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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: const Color(0xFFFEFCFC),
            border: Border.all(color: const Color(0xFFE3E2E2)),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: const Color(0xFF1C44F9),
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(
                model.icon,
                color: const Color(0xFFFFFFFF),
                size: 38,
              ),
            ),
            const H(18),
            Text(
              model.title,
              textAlign: TextAlign.start,
              style: AppTheme.text.extra
                  .sm(const Color(0xFF000C61))
                  .copyWith(fontSize: 16, height: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}
