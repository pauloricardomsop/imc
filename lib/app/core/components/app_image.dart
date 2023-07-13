import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final bool isSVG;
  final BoxFit fit;

  const AppImage({required this.url, this.height, this.width, this.isSVG = false, this.fit = BoxFit.fill, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height ?? 300,
      child: isSVG
          ? url.contains('http')
              ? SvgPicture.network(
                  url,
                  fit: fit,
                )
              : SvgPicture.asset(
                  url,
                  fit: fit,
                )
          : url.contains('http')
              ? Image.network(
                  url,
                  fit: fit,
                )
              : Image.asset(
                  url,
                  fit: fit,
                ),
    );
  }
}