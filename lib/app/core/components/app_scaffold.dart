import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rxdart/rxdart.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/components/app_shimmer.dart';
import 'package:svr/app/core/components/stream_out.dart';

class AppScaffold extends StatelessWidget {
  final Future<bool> Function()? onWillPop;
  final Widget body;
  final Color backgroundColor;
  final PreferredSizeWidget? appBar;
  final bool resizeAvoidBottom;
  final bool? active;
  final List<String>? behavior;

  const AppScaffold(
      {Key? key,
      required this.body,
      this.active = false,
      this.behavior,
      this.onWillPop,
      this.appBar,
      this.backgroundColor = const Color.fromARGB(255, 255, 255, 255),
      this.resizeAvoidBottom = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: true,
        bottom: true,
        child: WillPopScope(
          onWillPop: onWillPop,
          child: Scaffold(
            resizeToAvoidBottomInset: resizeAvoidBottom,
            appBar: appBar,
            backgroundColor: backgroundColor,
            body: getBody(),
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    if (active ?? false) {
      if (behavior != null) {
        if (behavior!.isNotEmpty) {
          List<BehaviorSubject<BannerAd?>>? streams =
              behavior!.map((e) => AdBannerStorage.get(e)).toList();

          return StreamOutNull<BannerAd?>(
            stream: streams[0].stream,
            loading: AppShimmer(child: body),
            child: (_, ad) => streams.length >= 2
                ? (StreamOutNull<BannerAd?>(
                    stream: streams[1].stream,
                    loading: AppShimmer(child: body),
                    child: (_, ad) => body,
                  ))
                : body,
          );
        } else {
          return body;
        }
      } else {
        return body;
      }
    } else {
      return body;
    }
  }

  // Widget streamBuilder() => StreamBuilder<BannerAd?>(
  //       stream: behavior!.stream,
  //       builder: (_, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.active) {
  //           if (snapshot.data != null) {
  //             return body;
  //           } else {
  //             return AppShimmer(child: body);
  //           }
  //         } else {
  //           return AppShimmer(child: body);
  //         }
  //       },
  //     );
}
