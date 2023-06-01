import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final bool isSVG;

  const AppImage({required this.url, this.height, this.width, this.isSVG = false, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height ?? 300,
      child: isSVG
          ? SvgPicture.network(
              url,
              fit: BoxFit.fill,
            )
          : Image.network(
              url,
              fit: BoxFit.fill,
            ),
    );
  }
}
