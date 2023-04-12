import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String url;
  final double? height;

  const AppImage({required this.url, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: height ?? 300,
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    );
  }
}
