import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rxdart/rxdart.dart';
import 'package:svr/app/core/components/splash_old_page.dart';
import 'package:svr/app/core/enums/module_enum.dart';
import 'package:svr/app/core/services/remote_config_service.dart';
import 'package:svr/app/core/utils/dialog_utils.dart';

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
      push(contextGlobal, const SplashOldPage());
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
    UtilsController().moduleStream.add(Module.home);
  }

  static BehaviorSubject<BannerAd?> adBannerStorage = BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> adBannerAccordeonStorage =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> adBannerSmartStorage = BehaviorSubject<BannerAd?>.seeded(null);

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

  static Future<void> fetchBannerAccordeon(List<String> ids, BehaviorSubject<BannerAd?> behavior,
      {bool fromStorage = false}) async {
    if (AdController.adConfig.bannerAccordeon.active) {
      if (!fromStorage && adBannerAccordeonStorage.value != null) {
        behavior.sink.add(adBannerAccordeonStorage.value);
        adBannerAccordeonStorage.add(null);
        fetchBannerAccordeon(ids, adBannerAccordeonStorage, fromStorage: true);
        return;
      }
      showToast('BANNER ACCORDEON | ${fromStorage ? 'PROXIMA' : 'ATUAL'} | ${ids.length}');
      await BannerAd(
        adUnitId: ids.first,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            behavior.sink.add(ad as BannerAd);
            if (!fromStorage && adBannerAccordeonStorage.value == null) {
              fetchBannerAccordeon(ids, adBannerAccordeonStorage, fromStorage: true);
            }
            showToastLoaded(
                'BANNER ACCORDEON | ${fromStorage ? 'PROXIMA' : 'ATUAL'} | ${ids.length}');
          },
          onAdFailedToLoad: (ad, error) async {
            if (AdConfig.checkWaterFallErrorCode(error.code)) {
              if (ids.isNotEmpty) ids.removeAt(0);
              if (ids.isNotEmpty) {
                await fetchBannerAccordeon(ids, behavior, fromStorage: fromStorage);
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

  static Future<void> fetchBannerSmart(List<String> ids, BehaviorSubject<BannerAd?> behavior,
      {bool fromStorage = false}) async {
    AnchoredAdaptiveBannerAdSize? size = await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(contextGlobal).size.width.toInt(),
    );

    if (AdController.adConfig.bannerSmart.active && size != null) {
      if (!fromStorage && adBannerSmartStorage.value != null) {
        behavior.sink.add(adBannerSmartStorage.value);
        adBannerSmartStorage.add(null);
        fetchBannerSmart(ids, adBannerSmartStorage, fromStorage: true);
        return;
      }

      showToast('BANNER SMART | ${fromStorage ? 'PROXIMA' : 'ATUAL'} | ${ids.length}');
      await BannerAd(
        adUnitId: ids.first,
        request: const AdRequest(),
        size: size,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            behavior.sink.add(ad as BannerAd);
            if (!fromStorage && adBannerSmartStorage.value == null) {
              fetchBannerSmart(ids, adBannerSmartStorage, fromStorage: true);
            }
            showToastLoaded('BANNER SMART | ${fromStorage ? 'PROXIMA' : 'ATUAL'} | ${ids.length}');
          },
          onAdFailedToLoad: (ad, error) async {
            if (AdConfig.checkWaterFallErrorCode(error.code)) {
              if (ids.isNotEmpty) ids.removeAt(0);
              if (ids.isNotEmpty) {
                await fetchBannerSmart(ids, behavior, fromStorage: fromStorage);
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

  //* REWARD TRANSITION

  static final AppStream<bool> rewardedLoadingTransitionStream = AppStream<bool>.seed(true);
  static final AppStream<RewardedAd?> rewardedTransitionStream = AppStream<RewardedAd?>();

  static Future<void> fetchRewardTransitionAd(List<String> ids, {Function? onComplete}) async {
    ForegroundService.showForegroundBack = false;
    showToast('REWARDED - ${ids.length}');
    if (rewardedTransitionStream.controller.hasValue &&
        rewardedTransitionStream.controller.value != null) {
      if (onComplete != null) onComplete.call();
      return;
    }
    await RewardedAd.load(
      adUnitId: ids.first,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          showToastLoaded('REWARDED - ${ids.length}');
          ad.fullScreenContentCallback = _rewardTransitionFullScreenCallback;
          rewardedLoadingTransitionStream.add(false);
          rewardedTransitionStream.add(ad);
          if (onComplete != null) onComplete.call();
        },
        onAdFailedToLoad: (LoadAdError error) async {
          if (AdConfig.checkWaterFallErrorCode(error.code)) {
            if (ids.isNotEmpty) ids.removeAt(0);
            if (ids.isNotEmpty) {
              await fetchRewardTransitionAd(ids, onComplete: onComplete);
            } else {
              _disposeRewardedTransitionAd();
              if (onComplete != null) onComplete.call();
            }
          } else {
            _disposeRewardedTransitionAd();
            if (onComplete != null) onComplete.call();
          }
        },
      ),
    );
  }

  static Function? onRewardedTransitionEarned;

  static void showRewardTransitionAd({Function? onComplete}) async {
    if (rewardedTransitionStream.value != null) {
      DialogUtils.showTransitionLoadingDialog();
      await Future.delayed(const Duration(seconds: 2));
      rewardedTransitionStream.value!.show(
        onUserEarnedReward: (ad, reward) {
          ForegroundService.showForegroundBack = true;
          onRewardedTransitionEarned = onComplete;
        },
      );
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.pop(contextGlobal);
      rewardedLoadingTransitionStream.add(true);
      fetchRewardTransitionAd(adConfig.rewardedTransition.id);
    } else {
      rewardedLoadingTransitionStream.add(true);
      fetchRewardTransitionAd(adConfig.rewardedTransition.id, onComplete: onComplete);
    }
  }

  static final FullScreenContentCallback<RewardedAd> _rewardTransitionFullScreenCallback =
      FullScreenContentCallback(
    onAdDismissedFullScreenContent: (RewardedAd ad) => _disposeRewardedTransitionAd(ad: ad),
    onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) =>
        _disposeRewardedTransitionAd(ad: ad),
  );

  static void _disposeRewardedTransitionAd({
    ad,
  }) {
    if (ad != null) {
      ad.dispose();
    }
    if (onRewardedTransitionEarned != null) {
      onRewardedTransitionEarned!.call();
      onRewardedTransitionEarned = null;
    }
    rewardedTransitionStream.add(null);
    rewardedLoadingTransitionStream.add(false);
    ForegroundService.showForegroundBack = true;
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
      _fetchIntersticialRewardAd(adConfig.rewarded.id,
          onComplete: () => _showRewardedIntersticialAd(onComplete: onComplete));
    }
  }

  static pushReplaceAndShowIntersticial(BuildContext context, Widget page) async {
    await showInterstitialAd(context, onComplete: () {
      Navigator.of(context).popUntil((route) => route.isFirst);
      push(context, page);
    });
  }

  //* IntersticialTransition

  static final AppStream<InterstitialAd?> interstitialTransitionStream =
      AppStream<InterstitialAd?>();

  static Future<void> fetchInterstitialTransitionAd(
    List<String> ids,
  ) async {
    if (ids.length == adConfig.intersticialTransition.id.length && _canShowIntersticialTransition) {
      return;
    }
    showToast('INTERSTICIAL - ${ids.length}');
    await InterstitialAd.load(
        adUnitId: ids.first,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            showToastLoaded('INTERSTICIAL - ${ids.length}');
            ad.fullScreenContentCallback = _intersticialTransitionFullScreenCallback();
            interstitialTransitionStream.add(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            if (AdConfig.checkWaterFallErrorCode(error.code)) {
              if (ids.isNotEmpty) ids.removeAt(0);
              if (ids.isNotEmpty) {
                fetchInterstitialTransitionAd(ids);
              } else {
                interstitialTransitionStream.add(null);
              }
            } else {
              interstitialTransitionStream.add(null);
            }
          },
        ));
  }

  static FullScreenContentCallback<InterstitialAd> _intersticialTransitionFullScreenCallback() =>
      FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) => _disposeIntersticialTransition(ad),
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) =>
            _disposeIntersticialTransition(ad),
      );

  static void _disposeIntersticialTransition(InterstitialAd ad) {
    ad.dispose();
    interstitialTransitionStream.add(null);
    UtilsController().ignoringStream.add(false);
  }

  static Future<bool> showInterstitialTransitionAd(BuildContext context,
      {Function? onComplete}) async {
    if (_canShowIntersticialTransition) {
      DialogUtils.showTransitionLoadingDialog();
      await Future.delayed(const Duration(seconds: 2));
      ForegroundService.showForegroundBack = false;
      UtilsController().ignoringStream.add(true);
      await interstitialTransitionStream.controller.value!.show();
      late StreamSubscription<InterstitialAd?> controller;
      controller =
          AdController.interstitialTransitionStream.controller.listen((InterstitialAd? data) {
        if (data == null) {
          controller.cancel();
          Navigator.pop(contextGlobal);
          if (onComplete != null) onComplete.call();
          ForegroundService.showForegroundBack = true;
          fetchInterstitialTransitionAd(adConfig.intersticialTransition.id);
        }
      });
      return false;
    } else {
      if (onComplete != null) onComplete.call();
      return false;
    }
  }

  static bool get _canShowIntersticialTransition =>
      AdController.adConfig.intersticialTransition.active &&
      interstitialTransitionStream.controller.hasValue &&
      interstitialTransitionStream.controller.value != null;

  // INTERSTICIAL REWARD TRANSITION

  static final rewardedIntersticialTransitionLoadingStream = AppStream<bool>.seed(true);
  static final rewardedIntersticialTransitionStream = AppStream<RewardedInterstitialAd?>();

  static Future<void> fetchIntersticialRewardTransitionAd(List<String> ids,
      {Function? onComplete}) async {
    if (!adConfig.intersticialRewardedTransition.active) {
      onComplete?.call();
      return;
    }
    ForegroundService.showForegroundBack = false;
    showToast("INTERSTICIAL REWARD TRANSITION - ${ids.length}");
    if (rewardedIntersticialTransitionStream.controller.hasValue &&
        rewardedIntersticialTransitionStream.controller.value != null) {
      if (onComplete != null) onComplete.call();
      return;
    }
    await RewardedInterstitialAd.load(
      adUnitId: ids.first,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          showToastLoaded('INTERSTICIAL REWARDED TRANSITION - ${ids.length}');
          ad.fullScreenContentCallback = _rewardIntersticialTransitionFullScreenCallback;
          rewardedIntersticialTransitionLoadingStream.add(false);
          rewardedIntersticialTransitionStream.add(ad);
          if (onComplete != null) onComplete.call();
        },
        onAdFailedToLoad: (LoadAdError error) async {
          if (AdConfig.checkWaterFallErrorCode(error.code)) {
            if (ids.isNotEmpty) ids.removeAt(0);
            if (ids.isNotEmpty) {
              await fetchIntersticialRewardTransitionAd(ids, onComplete: onComplete);
            } else {
              _disposeRewardedIntersticialTransitionAd(true);
              if (onComplete != null) onComplete.call();
            }
          } else {
            _disposeRewardedIntersticialTransitionAd(true);
            if (onComplete != null) onComplete.call();
          }
        },
      ),
    );
  }

  static final FullScreenContentCallback<RewardedInterstitialAd>
      _rewardIntersticialTransitionFullScreenCallback = FullScreenContentCallback(
    onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) =>
        _disposeRewardedIntersticialTransitionAd(true, ad),
    onAdFailedToShowFullScreenContent: (RewardedInterstitialAd ad, AdError error) =>
        _disposeRewardedIntersticialTransitionAd(true, ad),
  );

  static void _disposeRewardedIntersticialTransitionAd(data, [RewardedInterstitialAd? ad]) {
    if (ad != null) {
      ad.dispose();
    }
    rewardedIntersticialTransitionStream.add(null);
    rewardedIntersticialTransitionLoadingStream.add(false);
    ForegroundService.showForegroundBack = true;
    if (!_userEarned) {
      Navigator.pop(contextGlobal);
      _userEarned = true;
    }
    fetchIntersticialRewardTransitionAd(adConfig.intersticialRewardedTransition.id);
  }

  static bool _userEarned = false;
  static void showRewardedIntersticialTransitionAd({Function? onComplete}) async {
    if (!adConfig.intersticialRewardedTransition.active) {
      onComplete?.call();
      return;
    }
    _userEarned = false;
    DialogUtils.showTransitionLoadingDialog();
    await Future.delayed(const Duration(seconds: 2));
    fetchIntersticialRewardTransitionAd(adConfig.intersticialRewardedTransition.id);
    if (rewardedIntersticialTransitionStream.controller.hasValue &&
        rewardedIntersticialTransitionStream.value != null) {
      rewardedIntersticialTransitionStream.value!.show(
        onUserEarnedReward: (ad, reward) {
          ForegroundService.showForegroundBack = true;
          Navigator.pop(contextGlobal);
          _userEarned = true;
          onComplete?.call();
          fetchIntersticialRewardTransitionAd(adConfig.intersticialRewardedTransition.id);
        },
      );
    } else {
      rewardedLoadingStream.add(true);
      fetchIntersticialRewardTransitionAd(adConfig.intersticialRewardedTransition.id);
      Navigator.pop(contextGlobal);
      onComplete?.call();
    }
  }

  static void showToast(String text) {
    try {
      // ScaffoldMessenger.of(contextGlobal).showSnackBar(Sn ackBar(
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
