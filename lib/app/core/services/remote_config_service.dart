import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/ad/ad_model.dart';
import 'package:svr/app/modules/splash/splah_controller.dart';
import 'package:svr/app/modules/splash/splash_model.dart';

class RemoteConfigService {
  static FirebaseRemoteConfig get instance => FirebaseRemoteConfig.instance;

  static const bool useDefaultValues = false;

  static Future<void> init() async {
    await instance.setConfigSettings(_configSettings);
    await instance.setDefaults(defaultMap);
    await instance.fetchAndActivate();
    _setValues();
  }

  static void _setValues() {
    AdController.adConfigStream.add(adConfig);
    SplashController().tips = tips;
  }

  static final RemoteConfigSettings _configSettings = RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(seconds: 30),
  );

  static final Map<String, dynamic> defaultMap = {
    RemoteConfigKey.adConfig: jsonEncode(AdConfig.configDefault),
    RemoteConfigKey.tips: jsonEncode(SplashTips.values),
    RemoteConfigKey.queryEnable: true,
  };

  static AdConfig get adConfig {
    try {
      if (useDefaultValues) {
        return AdConfig.fromJson(jsonDecode(defaultMap[RemoteConfigKey.adConfig]));
      }
      return AdConfig.fromJson(jsonDecode(instance.getString(RemoteConfigKey.adConfig)));
    } catch (e) {
      return AdConfig.fromJson(jsonDecode(defaultMap[RemoteConfigKey.adConfig]));
    }
  }

  static List<String> get tips {
    try {
      if (useDefaultValues) {
        return jsonDecode(instance.getString(RemoteConfigKey.tips)).cast<String>();
      }
      return jsonDecode(instance.getString(RemoteConfigKey.tips));
    } catch (e) {
      return jsonDecode(defaultMap[RemoteConfigKey.tips]).cast<String>();
    }
  }

  static bool get showBanner => AdController.adConfig.banner.active;
  static bool get showBannerAccordeon => AdController.adConfig.bannerAccordeon.active;
  static bool get showBannerSmart => AdController.adConfig.bannerSmart.active;
}

class RemoteConfigKey {
  static const String adConfig = 'ad_config';
  static const String paymentCalendarNIS = 'payment_calendar_nis';
  static const String queryEnable = 'query_enable';
  static const String tips = 'tups';
}
