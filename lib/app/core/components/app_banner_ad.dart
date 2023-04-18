import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rxdart/rxdart.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
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
    if (RemoteConfigService.showBanner) return const BannerTransparent();
    return AdController.adConfig.banner.active
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[100],
            ),
            child: Center(
              child: StreamBuilder<BannerAd?>(
                stream: widget.behavior.stream,
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data != null) {
                      return SizedBox(
                          width: snapshot.data!.size.width.toDouble(),
                          height: snapshot.data!.size.height.toDouble(),
                          child: AdWidget(ad: snapshot.data!));
                    } else {
                      return const BannerTransparent();
                    }
                  } else {
                    return const AppShimmer(child: BannerTransparent());
                  }
                },
              ),
            ),
          )
        : const SizedBox();
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
    if (RemoteConfigService.showBannerAccordeon) return const BannerSmallTransparent();
    return AdController.adConfig.bannerAccordeon.active
        ? Center(
          child: StreamBuilder<BannerAd?>(
            stream: widget.behavior.stream,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data != null) {
                  return SizedBox(
                      width: snapshot.data!.size.width.toDouble(),
                      height: snapshot.data!.size.height.toDouble(),
                      child: AdWidget(ad: snapshot.data!));
                } else {
                  return const BannerSmallTransparent();
                }
              } else {
                return const AppShimmer(child: BannerSmallTransparent());
              }
            },
          ),
        )
        : const SizedBox();
  }
}
