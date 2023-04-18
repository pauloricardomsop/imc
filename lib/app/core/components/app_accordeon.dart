import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/models/carroussel_model.dart';
import 'package:svr/app/core/theme/app_theme.dart';

class AppAccordeon extends StatefulWidget {
  final List<AccordeonModel> itens;

  const AppAccordeon(this.itens, {super.key});

  @override
  State<AppAccordeon> createState() => _AppAccordeonState();
}

class _AppAccordeonState extends State<AppAccordeon> {
  @override
  void initState() {
    AdController.fetchBannerAccordeon(
      AdController.adConfig.bannerAccordeon.id,
      AdController.adBannerAccordeonStorage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.theme.copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Column(children: widget.itens.map((e) => _item(e)).toList()),
    );
  }

  Widget _item(AccordeonModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE3E2E2))),
      child: ExpansionTile(
        key: item.key,
        initiallyExpanded: false,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: EdgeInsets.zero,
        title: Text(
          item.title,
          style: AppTheme.text.semi.lg(const Color(0xFF1B1C1C)),
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: Alignment.centerLeft,
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFDDE0FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            item.expanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
            color: const Color(0xFF000C61),
            size: 30,
          ),
        ),
        onExpansionChanged: (bool expanded) {
          if (expanded) {
            for (var i in widget.itens) {
              if (i == item) {
                i.expanded = true;
                AdController.fetchBannerAccordeon(
                  AdController.adConfig.bannerAccordeon.id,
                  AdBannerStorage.get(item.bannerKey),
                );
                AdController.fetchBannerAccordeon(
                  AdController.adConfig.bannerAccordeon.id,
                  AdController.adBannerAccordeonStorage,
                );
              } else {
                i.expanded = false;
                _collapse(i);
              }
            }
          } else {
            item.expanded = false;
            _collapse(item);
          }
          setState(() {});
        },
        children: [
          Container(
            width: double.maxFinite,
            height: 1,
            color: const Color(0xFFE3E2E2),
          ),
          const H(16),
          AppSmallBannerAd(AdBannerStorage.get(item.bannerKey)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  item.desc,
                  style: AppTheme.text.normal.base(const Color(0xFF474747)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _collapse(AccordeonModel item) {
    int? newKey;
    do {
      newKey = Random().nextInt(10000);
    } while (newKey == item.keyValue);
    item.keyValue = newKey;
    item.key = Key(newKey.toString());
  }
}
