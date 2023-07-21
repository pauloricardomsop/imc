import 'package:flutter/material.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/w.dart';
import 'package:svr/app/core/theme/app_theme.dart';

class AppCardModel {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Function()? onTap;
  final Widget? child;
  final bool premium;

  AppCardModel({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.child,
    this.premium = false,
  });
}

class AppCardList extends StatelessWidget {
  final List<AppCardModel> models;

  const AppCardList(this.models, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: models.length,
      itemBuilder: (_, i) => AppCard(models[i]),
      separatorBuilder: (_, i) => const H(16),
    );
  }
}

class AppCard extends StatelessWidget {
  final AppCardModel model;

  const AppCard(
    this.model, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => model.onTap?.call(),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFEFCFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE3E2E2),
            width: 1,
          ),
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1C44F9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              model.icon,
              size: 42,
              color: const Color(0xFFFFFFFF),
            ),
          ),
          const W(16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        model.title,
                        style: AppTheme.text.extra.xl(
                          const Color(0xFF000C61),
                        ),
                      ),
                    ),
                  ],
                ),
                if (model.child != null) model.child!,
                if (model.subtitle != null)
                  Text(
                    model.subtitle!,
                    style: AppTheme.text.normal.sm(
                      const Color(0xFF474747),
                    ),
                  ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
