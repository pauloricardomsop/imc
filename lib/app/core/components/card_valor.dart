// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/w.dart';
import 'package:svr/app/core/theme/app_theme.dart';

class CardValor extends StatelessWidget {
  final String title;
  final String value;
  final String desc;
  final Function? onClick;

  const CardValor({
    Key? key,
    required this.title,
    required this.value,
    required this.desc,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick?.call(),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: const Color(0xFFFEFCFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE3E2E2))),
        child: Column(
          children: [
            Text(
              title,
              style: AppTheme.text.normal.sm(const Color(0xFF474747)),
            ),
            const H(8),
            Text(
              value,
              style: AppTheme.text.extra.xl3(const Color(0xFF1B1C1C)),
            ),
            const H(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  desc,
                  style: onClick != null
                      ? AppTheme.text.extra.base(const Color(0xFF1C44F9))
                      : AppTheme.text.normal.sm(const Color(0xFF777777)),
                ),
                if (onClick != null) const W(8),
                if (onClick != null)
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: Color(0xFF1C44F9),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
