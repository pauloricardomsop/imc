import 'dart:convert';

import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/ad/ad_model.dart';
import 'package:benefits_brazil/app/core/models/calendar_model.dart';
import 'package:benefits_brazil/app/modules/bf/calendar/bf_calendar_controller.dart';
import 'package:benefits_brazil/app/modules/splash/splah_controller.dart';
import 'package:benefits_brazil/app/modules/splash/splash_model.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static FirebaseRemoteConfig get instance => FirebaseRemoteConfig.instance;

  static const bool _useDefaultValues = false;

  static Future<void> init() async {
    await instance.setConfigSettings(_configSettings);
    await instance.setDefaults(defaultMap);
    await instance.fetchAndActivate();
    _setValues();
  }

  static void _setValues() {
    AdController.adConfigStream.add(adConfig);
    BfCalendarController().calendar = paymentCalendarNIS;
    SplashController().tips = tips;
    AdController.queryEnableStream.add(queryEnable);
  }

  static final RemoteConfigSettings _configSettings = RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(seconds: 30),
  );

  static final Map<String, dynamic> defaultMap = {
    RemoteConfigKey.adConfig: jsonEncode(AdConfig.configDefault),
    RemoteConfigKey.paymentCalendarNIS: jsonEncode(Calendar.calendar2023Update),
    RemoteConfigKey.tips: jsonEncode(SplashTips.values),
    RemoteConfigKey.queryEnable: true,
  };

  static AdConfig get adConfig {
    try {
      if (_useDefaultValues) {
        return AdConfig.fromJson(jsonDecode(defaultMap[RemoteConfigKey.adConfig]));
      }
      return AdConfig.fromJson(jsonDecode(instance.getString(RemoteConfigKey.adConfig)));
    } catch (e) {
      return AdConfig.fromJson(jsonDecode(defaultMap[RemoteConfigKey.adConfig]));
    }
  }

  static List<List<String>> get paymentCalendarNIS {
    try {
      if (_useDefaultValues) {
        return Calendar.parse(jsonDecode(defaultMap[RemoteConfigKey.paymentCalendarNIS]));
      }
      return Calendar.parse(jsonDecode(instance.getString(RemoteConfigKey.paymentCalendarNIS)));
    } catch (e) {
      return Calendar.parse(jsonDecode(defaultMap[RemoteConfigKey.paymentCalendarNIS]));
    }
  }

  static List<String> get tips {
    try {
      if (_useDefaultValues) {
        return jsonDecode(instance.getString(RemoteConfigKey.tips)).cast<String>();
      }
      return jsonDecode(instance.getString(RemoteConfigKey.tips));
    } catch (e) {
      return jsonDecode(defaultMap[RemoteConfigKey.tips]).cast<String>();
    }
  }

  static bool get queryEnable {
    try {
      if (_useDefaultValues) {
        return defaultMap[RemoteConfigKey.queryEnable];
      }
      return instance.getBool(RemoteConfigKey.queryEnable);
    } catch (e) {
      return defaultMap[RemoteConfigKey.queryEnable];
    }
  }

  static bool get showBanner => _useDefaultValues;
}

class RemoteConfigKey {
  static const String adConfig = 'ad_config';
  static const String paymentCalendarNIS = 'payment_calendar_nis';
  static const String queryEnable = 'query_enable';
  static const String tips = 'tups';
}
