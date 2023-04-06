import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/theme/app_theme.dart';

class HeaderHero extends StatelessWidget {
  final String? image;
  final String title;
  final String desc;
  const HeaderHero({this.image, required this.title, required this.desc, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image != null)
          Container(
            width: double.maxFinite,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: CachedNetworkImageProvider(image!), fit: BoxFit.cover),
            ),
          ),
        if (image != null) const H(16),
        Text(
          title,
          style: AppTheme.text.extra.xl3(const Color(0xFF1B1C1C)),
        ),
        const H(8),
        Text(desc, style: AppTheme.text.normal.base(const Color(0xFF474747))),
      ],
    );
  }
}
