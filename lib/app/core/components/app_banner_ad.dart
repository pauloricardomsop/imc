import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rxdart/rxdart.dart';
import 'package:svr/app/core/components/app_shimmer.dart';
import 'package:svr/app/core/components/banner_transparent.dart';
import 'package:svr/app/core/services/remote_config_service.dart';

class AppBannerAd extends StatefulWidget {
  final BehaviorSubject<BannerAd?> behavior;

  const AppBannerAd(
    this.behavior, {
    Key? key,
  }) : super(key: key);

  @override
  State<AppBannerAd> createState() => _AppBannerAdState();
}

class _AppBannerAdState extends State<AppBannerAd> {
  @override
  Widget build(BuildContext context) {
    if (!RemoteConfigService.showBanner) return const BannerTransparent();
    return Center(
      child: StreamBuilder<BannerAd?>(
        stream: widget.behavior.stream,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.active && snapshot.data != null) {
            return SizedBox(
                width: snapshot.data!.size.width.toDouble(),
                height: snapshot.data!.size.height.toDouble(),
                child: AdWidget(ad: snapshot.data!));
          } else {
            return const AppShimmer(child: BannerTransparent());
          }
        },
      ),
    );
  }
}

class AppSmallBannerAd extends StatefulWidget {
  final BehaviorSubject<BannerAd?> behavior;

  const AppSmallBannerAd(
    this.behavior, {
    Key? key,
  }) : super(key: key);

  @override
  State<AppSmallBannerAd> createState() => _AppSmallBannerAdState();
}

class _AppSmallBannerAdState extends State<AppSmallBannerAd> {
  @override
  Widget build(BuildContext context) {
    if (!RemoteConfigService.showBannerAccordeon) return const BannerTransparent();
    return Center(
      child: StreamBuilder<BannerAd?>(
        stream: widget.behavior.stream,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.active && snapshot.data != null) {
            return SizedBox(
                width: snapshot.data!.size.width.toDouble(),
                height: snapshot.data!.size.height.toDouble(),
                child: AdWidget(ad: snapshot.data!));
          } else {
            return const AppShimmer(child: BannerSmallTransparent());
          }
        },
      ),
    );
  }
}

class AppSmartBannerAd extends StatefulWidget {
  final BehaviorSubject<BannerAd?> behavior;

  const AppSmartBannerAd(
    this.behavior, {
    Key? key,
  }) : super(key: key);

  @override
  State<AppSmartBannerAd> createState() => _AppSmartBannerAdState();
}

class _AppSmartBannerAdState extends State<AppSmartBannerAd> {
  @override
  Widget build(BuildContext context) {
    if (!RemoteConfigService.showBannerSmart) return const SizedBox();
    return StreamBuilder<BannerAd?>(
      stream: widget.behavior.stream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active && snapshot.data != null) {
          return SizedBox(
              width: snapshot.data!.size.width.toDouble(),
              height: snapshot.data!.size.height.toDouble(),
              child: AdWidget(ad: snapshot.data!));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
