import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_shimmer.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class AppScaffold extends StatefulWidget {
  final Future<bool> Function()? onWillPop;
  final List<String>? behavior;
  final bool active;
  final Widget child;
  final Widget? bottom;
  final bool removeSmartBanner;

  const AppScaffold(
      {Key? key,
      required this.child,
      this.active = false,
      this.behavior,
      this.onWillPop,
      this.bottom,
      this.removeSmartBanner = false})
      : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  void initState() {
    AdController.fetchBannerSmart(
      AdController.adConfig.bannerSmart.id,
      AdBannerStorage.get(bannerSmartKey),
    );
    super.initState();
  }

  String get bannerSmartKey {
    if (widget.behavior != null) {
      String key = 'smart_';
      for (var item in widget.behavior!) {
        key = '${key}_$item';
      }
      return key;
    } else {
      return empty;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: WillPopScope(
          onWillPop: widget.onWillPop ??
              () async {
                // AdController.showInterstitialAd(context);
                return true;
              },
          child: Scaffold(
            extendBody: true,
            backgroundColor: const Color(0xFFFFFFFF),
            body: Builder(
              builder: (context) {
                if (!widget.active || widget.behavior == null || widget.behavior!.isEmpty) {
                  return _body(context, widget.child);
                }
                final streams = AdBannerStorage.getList(widget.behavior);
                return _streamWidget(streams, streams.first);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _streamWidget(List<Stream<BannerAd?>> values, Stream<BannerAd?> value) {
    return StreamOutNull<BannerAd?>(
      stream: value,
      loading: AppShimmer(child: _body(context, widget.child)),
      child: (_, ad) => value == values.last
          ? _body(context, widget.child)
          : _streamWidget(values, values[values.indexOf(value) + 1]),
    );
  }

  Widget _body(BuildContext context, Widget child) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView(
          children: [widget.child, if (!widget.removeSmartBanner) const H(60)],
        ),
        if (!widget.removeSmartBanner)
          Align(
            alignment: Alignment.bottomCenter,
            child: _bottom(),
          )
      ],
    );
  }

  Widget _bottom() {
    final banner = AppSmartBannerAd(
      AdBannerStorage.get(bannerSmartKey),
      inBottom: widget.bottom != null,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [banner, if (widget.bottom != null) widget.bottom!],
    );
  }
}
