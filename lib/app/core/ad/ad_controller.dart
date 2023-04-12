import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rxdart/rxdart.dart';
import 'package:svr/app/core/services/remote_config_service.dart';

import '../../modules/splash/splah_controller.dart';
import '../../modules/splash/ui/splash_page.dart';
import '../models/app_stream.dart';
import '../services/foreground_service.dart';
import '../services/notification_service.dart';
import '../utils/global_resource.dart';
import '../utils/utils_controller.dart';
import 'ad_model.dart';

class AdController {
  static final AppStream<AdConfig> adConfigStream = AppStream<AdConfig>.seed(
      AdConfig.fromJson(jsonDecode(RemoteConfigService.defaultMap[RemoteConfigKey.adConfig])));
  static AdConfig get adConfig => adConfigStream.value;

  static final AppStream<bool> queryEnableStream =
      AppStream<bool>.seed(RemoteConfigService.defaultMap[RemoteConfigKey.queryEnable]);

  //* Intersticial

  static final AppStream<InterstitialAd?> interstitialStream = AppStream<InterstitialAd?>();

  static Future<void> fetchInterstitialAd(List<String> ids, {bool fromNotification = false}) async {
    if (ids.length == adConfig.intersticial.id.length && _canShowIntersticial) {
      return;
    }
    showToast('INTERSTICIAL - ${ids.length}');
    await InterstitialAd.load(
        adUnitId: ids.first,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            showToastLoaded('INTERSTICIAL - ${ids.length}');
            ad.fullScreenContentCallback = _intersticialFullScreenCallback(fromNotification);
            interstitialStream.add(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            if (AdConfig.checkWaterFallErrorCode(error.code)) {
              if (ids.isNotEmpty) ids.removeAt(0);
              if (ids.isNotEmpty) {
                fetchInterstitialAd(ids);
              } else {
                interstitialStream.add(null);
              }
            } else {
              interstitialStream.add(null);
            }
          },
        ));
  }

  static FullScreenContentCallback<InterstitialAd> _intersticialFullScreenCallback(
          bool fromNotification) =>
      FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) =>
            _disposeIntersticial(ad, fromNotification),
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) =>
            _disposeIntersticial(ad, fromNotification),
      );

  static void _disposeIntersticial(InterstitialAd ad, bool fromNotification) {
    ad.dispose();
    interstitialStream.add(null);
    UtilsController().ignoringStream.add(false);
    if (fromNotification) Navigator.pop(contextGlobal);
  }

  static Future<bool> showInterstitialAd(BuildContext context,
      {Function? onComplete, bool pop = true}) async {
    if (_canShowIntersticial) {
      ForegroundService.showForegroundBack = false;
      UtilsController().ignoringStream.add(true);
      await interstitialStream.controller.value!.show();
      late StreamSubscription<InterstitialAd?> controller;
      controller = AdController.interstitialStream.controller.listen((InterstitialAd? data) {
        if (data == null) {
          controller.cancel();
          if (pop) Navigator.pop(context);
          if (onComplete != null) onComplete.call();
          ForegroundService.showForegroundBack = true;
        }
      });
      return false;
    } else {
      if (pop) Navigator.pop(context);
      if (onComplete != null) onComplete.call();
      return false;
    }
  }

  static bool get _canShowIntersticial =>
      AdController.adConfig.intersticial.active &&
      interstitialStream.controller.hasValue &&
      interstitialStream.controller.value != null;

  static Future<void> showInsterticialAdNotification(List<String> ids, String url) async {
    ForegroundService.showForegroundBack = false;
    if (AdController.adConfig.intersticial.active) {
      push(contextGlobal, const SplashPage());
    }
    AdController.fetchInterstitialAd(ids,
        fromNotification: AdController.adConfig.intersticial.active);
    late StreamSubscription<InterstitialAd?> controller;
    controller = AdController.interstitialStream.controller.listen((InterstitialAd? data) {
      if (data != null) {
        data.show();
      } else {
        controller.cancel();
      }
    });
  }

  static Future<void> checkAndshowQueryAd({Function? onComplete}) async {
    if (AdController.adConfig.canShowRewardedAd) {
      await AdController.showRewardAd(onComplete: onComplete);
    } else {
      onComplete?.call();
    }
  }

  //* OPENED APP

  static Future<void> fetchOpenedAppAd(List<String> ids, {bool fromBackground = false}) async {
    showToast('OPENEDEDAPP - ${ids.length}');
    await AppOpenAd.load(
      adUnitId: ids.first,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          final splashController = SplashController();
          splashController.splash.value.label = 'App Iniciado';
          splashController.splash.value.progress = 100;
          splashController.splash.add(splashController.splash.value);
          showToastLoaded('OPENEDEDAPP - ${ids.length}');
          ad.fullScreenContentCallback = _openedApFullScreenCallback(fromBackground);
          ad.show();
        },
        onAdFailedToLoad: (error) {
          if (AdConfig.checkWaterFallErrorCode(error.code)) {
            if (ids.isNotEmpty) ids.removeAt(0);
            if (ids.isNotEmpty) {
              fetchOpenedAppAd(ids, fromBackground: fromBackground);
            } else {
              _disposeOpenAd();
            }
          } else {
            _disposeOpenAd();
          }
        },
      ),
    );
  }

  static FullScreenContentCallback<AppOpenAd> _openedApFullScreenCallback(
    bool fromBackground,
  ) =>
      FullScreenContentCallback(
        onAdFailedToShowFullScreenContent: (ad, error) =>
            _disposeOpenAd(ad: ad, fromBackground: fromBackground),
        onAdDismissedFullScreenContent: (ad) =>
            _disposeOpenAd(ad: ad, fromBackground: fromBackground),
      );

  static void _disposeOpenAd({
    AppOpenAd? ad,
    bool fromBackground = false,
  }) async {
    if (ad != null) ad.dispose();
    if (fromBackground) {
      Navigator.pop(contextGlobal);
      if (urlToShow != null) {
        execUrl(urlToShow!);
        urlToShow = null;
      }
    } else {
      handleInitialMessage(await FirebaseMessaging.instance.getInitialMessage());
      ForegroundService.showForegroundBack = true;
    }
    SplashController().dispose();
  }

  static BehaviorSubject<BannerAd?> adBannerStorage = BehaviorSubject<BannerAd?>.seeded(null);

  //* BANNER

  static Future<void> fetchBanner(List<String> ids, BehaviorSubject<BannerAd?> behavior,
      {bool fromStorage = false}) async {
    if (AdController.adConfig.banner.active) {
      if (!fromStorage && adBannerStorage.value != null) {
        behavior.sink.add(adBannerStorage.value);
        adBannerStorage.add(null);
        fetchBanner(ids, adBannerStorage, fromStorage: true);
        return;
      }
      showToast('BANNER | ${fromStorage ? 'PROXIMA' : 'ATUAL'} | ${ids.length}');
      await BannerAd(
        adUnitId: ids.first,
        request: const AdRequest(),
        size: AdSize.mediumRectangle,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            behavior.sink.add(ad as BannerAd);
            if (!fromStorage && adBannerStorage.value == null) {
              fetchBanner(ids, adBannerStorage, fromStorage: true);
            }
            showToastLoaded('BANNER | ${fromStorage ? 'PROXIMA' : 'ATUAL'} | ${ids.length}');
          },
          onAdFailedToLoad: (ad, error) async {
            if (AdConfig.checkWaterFallErrorCode(error.code)) {
              if (ids.isNotEmpty) ids.removeAt(0);
              if (ids.isNotEmpty) {
                await fetchBanner(ids, behavior, fromStorage: fromStorage);
              } else {
                behavior.sink.add(ad as BannerAd);
              }
            } else {
              behavior.sink.add(ad as BannerAd);
            }
          },
        ),
      ).load();
    }
  }

  //* QUERY

  static Future<void> fetchRewardAd({Function? onComplete}) async {
    if (!adConfig.activeAll) {
      onComplete?.call();
      return;
    }
    if (adConfig.rewarded.active) {
      _fetchRewardAd(adConfig.rewarded.id, onComplete: onComplete);
    } else if (adConfig.intersticialRewarded.active) {
      _fetchIntersticialRewardAd(adConfig.intersticialRewarded.id, onComplete: onComplete);
    } else {
      onComplete?.call();
    }
  }

  static Future<void> showRewardAd({Function? onComplete}) async {
    if (!adConfig.activeAll) {
      onComplete?.call();
      return;
    }
    if (adConfig.rewarded.active) {
      _showRewardAd(onComplete: onComplete);
    } else if (adConfig.intersticialRewarded.active) {
      _showRewardedIntersticialAd(onComplete: onComplete);
    } else {
      onComplete?.call();
    }
  }

  //* REWARD

  static final AppStream<bool> rewardedLoadingStream = AppStream<bool>.seed(true);
  static final AppStream<RewardedAd?> rewardedStream = AppStream<RewardedAd?>();

  static Future<void> _fetchRewardAd(List<String> ids, {Function? onComplete}) async {
    ForegroundService.showForegroundBack = false;
    showToast('REWARDED - ${ids.length}');
    if (rewardedStream.controller.hasValue && rewardedStream.controller.value != null) {
      if (onComplete != null) onComplete.call();
      return;
    }
    await RewardedAd.load(
      adUnitId: ids.first,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          showToastLoaded('REWARDED - ${ids.length}');
          ad.fullScreenContentCallback = _rewardFullScreenCallback;
          rewardedLoadingStream.add(false);
          rewardedStream.add(ad);
          if (onComplete != null) onComplete.call();
        },
        onAdFailedToLoad: (LoadAdError error) async {
          if (AdConfig.checkWaterFallErrorCode(error.code)) {
            if (ids.isNotEmpty) ids.removeAt(0);
            if (ids.isNotEmpty) {
              await _fetchRewardAd(ids, onComplete: onComplete);
            } else {
              _disposeRewardedAd(true);
              if (onComplete != null) onComplete.call();
            }
          } else {
            _disposeRewardedAd(true);
            if (onComplete != null) onComplete.call();
          }
        },
      ),
    );
  }

  static final FullScreenContentCallback<RewardedAd> _rewardFullScreenCallback =
      FullScreenContentCallback(
    onAdDismissedFullScreenContent: (RewardedAd ad) => _disposeRewardedAd(true, ad),
    onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) =>
        _disposeRewardedAd(true, ad),
  );

  static void _disposeRewardedAd(data, [RewardedAd? ad]) {
    if (ad != null) {
      ad.dispose();
    }
    rewardedStream.add(null);
    rewardedLoadingStream.add(false);
    ForegroundService.showForegroundBack = true;
  }

  static void _showRewardAd({Function? onComplete}) async {
    if (rewardedStream.value != null) {
      rewardedStream.value!.show(
        onUserEarnedReward: (ad, reward) {
          ForegroundService.showForegroundBack = true;
          onComplete?.call();
        },
      );
      rewardedLoadingStream.add(true);
      _fetchRewardAd(adConfig.rewarded.id);
    } else {
      rewardedLoadingStream.add(true);
      _fetchRewardAd(adConfig.rewarded.id, onComplete: onComplete);
    }
  }

  //* INTERSTICIAL REWARD

  static final AppStream<bool> rewardedIntersticialLoadingStream = AppStream<bool>.seed(true);
  static final AppStream<RewardedInterstitialAd?> rewardedIntersticialStream =
      AppStream<RewardedInterstitialAd?>();

  static Future<void> _fetchIntersticialRewardAd(List<String> ids, {Function? onComplete}) async {
    ForegroundService.showForegroundBack = false;
    showToast("INTERSTICIAL REWARD - ${ids.length}");
    if (rewardedIntersticialStream.controller.hasValue &&
        rewardedIntersticialStream.controller.value != null) {
      if (onComplete != null) onComplete.call();
      return;
    }
    await RewardedInterstitialAd.load(
      adUnitId: ids.first,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          showToastLoaded('INTERSTICIAL REWARDED - ${ids.length}');
          ad.fullScreenContentCallback = _rewardIntersticialFullScreenCallback;
          rewardedIntersticialLoadingStream.add(false);
          rewardedIntersticialStream.add(ad);
          if (onComplete != null) onComplete.call();
        },
        onAdFailedToLoad: (LoadAdError error) async {
          if (AdConfig.checkWaterFallErrorCode(error.code)) {
            if (ids.isNotEmpty) ids.removeAt(0);
            if (ids.isNotEmpty) {
              await _fetchIntersticialRewardAd(ids, onComplete: onComplete);
            } else {
              _disposeRewardedIntersticialAd(true);
              if (onComplete != null) onComplete.call();
            }
          } else {
            _disposeRewardedIntersticialAd(true);
            if (onComplete != null) onComplete.call();
          }
        },
      ),
    );
  }

  static final FullScreenContentCallback<RewardedInterstitialAd>
      _rewardIntersticialFullScreenCallback = FullScreenContentCallback(
    onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) =>
        _disposeRewardedIntersticialAd(true, ad),
    onAdFailedToShowFullScreenContent: (RewardedInterstitialAd ad, AdError error) =>
        _disposeRewardedIntersticialAd(true, ad),
  );

  static void _disposeRewardedIntersticialAd(data, [RewardedInterstitialAd? ad]) {
    if (ad != null) {
      ad.dispose();
    }
    rewardedIntersticialStream.add(null);
    rewardedIntersticialLoadingStream.add(false);
    ForegroundService.showForegroundBack = true;
    // Navigator.pop(contextGlobal, data);
  }

  static void _showRewardedIntersticialAd({Function? onComplete}) async {
    if (rewardedIntersticialStream.value != null) {
      rewardedIntersticialStream.value!.show(
        onUserEarnedReward: (ad, reward) {
          ForegroundService.showForegroundBack = true;
          onComplete?.call();
        },
      );
    } else {
      rewardedLoadingStream.add(true);
      _fetchRewardAd(adConfig.rewarded.id,
          onComplete: () => _showRewardedIntersticialAd(onComplete: onComplete));
    }
  }

  static pushReplaceAndShowIntersticial(BuildContext context, Widget page) async {
    await showInterstitialAd(context, onComplete: () {
      Navigator.of(context).popUntil((route) => route.isFirst);
      push(context, page);
    });
  }

  static void showToast(String text) {
    try {
      // ScaffoldMessenger.of(contextGlobal).showSnackBar(SnackBar(
      //   content: Text(text),
      //   duration: const Duration(seconds: 1),
      // ));
    } catch (e) {}
  }

  static void showToastLoaded(String text) {
    try {
      // ScaffoldMessenger.of(contextGlobal).showSnackBar(SnackBar(
      //   content: Text(text),
      //   backgroundColor: Colors.green,
      //   duration: const Duration(seconds: 1),
      // ));
    } catch (e) {}
  }
}
