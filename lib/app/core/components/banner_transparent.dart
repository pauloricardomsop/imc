import 'package:flutter/material.dart';
import 'package:svr/app/core/components/app_shimmer.dart';

class BannerTransparent extends StatelessWidget {
  const BannerTransparent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 42),
      height: 250,
      width: 300,
      color: Colors.grey,
    );
  }
}

class BannerSmallTransparent extends StatelessWidget {
  const BannerSmallTransparent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Center(
        child: Container(
          height: 50,
          width: 320,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class BannerSmartTransparent extends StatelessWidget {
  const BannerSmartTransparent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        height: 64,
        width: double.maxFinite,
        color: Colors.grey,
      ),
    );
  }
}
