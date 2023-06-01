import 'package:flutter/material.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/w.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppRate extends StatelessWidget {
  const AppRate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFDDE0FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Avaliar app',
              textAlign: TextAlign.center, style: AppTheme.text.extra.xl2(const Color(0xFF1B1C1C))),
          const H(8),
          Text(
            'Avalie nosso app, é muito importante para\nnós o seu feedback!',
            textAlign: TextAlign.center,
            style: AppTheme.text.normal.sm(const Color(0xFF1B1C1C)),
          ),
          const H(12),
          IntrinsicWidth(
            child: InkWell(
              onTap: () =>
                  launchUrlString('https://play.google.com/store/apps/details?id=com.ldcapps.svr'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C44F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 32,
                      color: Color(0xFFFFE500),
                    ),
                    const W(8),
                    Text(
                      'AVALIAR',
                      textAlign: TextAlign.center,
                      style: AppTheme.text.normal
                          .xl(const Color(0xFFFFFFFF))
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
