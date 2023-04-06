import 'package:benefits_brazil/app/core/models/carroussel_model.dart';
import 'package:benefits_brazil/app/core/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';

class AppItemCarroussel extends StatelessWidget {
  final CarrousselModel item;

  const AppItemCarroussel(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE3E2E2))),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: AppTheme.text.semi.lg(const Color(0xFF1B1C1C)),
            ),
            Container(
              width: double.maxFinite,
              height: 1,
              color: const Color(0xFFE3E2E2),
              margin: const EdgeInsets.symmetric(vertical: 12),
            ),
            Text(
              item.desc,
              style: AppTheme.text.normal.base(const Color(0xFF474747)),
            ),
            if (item.alert != null)
              Text(
                item.alert!,
                style: AppTheme.text.semi.base(const Color(0xFF474747)),
              ),
          ],
        ),
      ),
    );
  }
}
