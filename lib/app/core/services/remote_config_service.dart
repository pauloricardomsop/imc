import 'dart:convert';
import 'dart:developer';
import 'package:svr/app/core/models/service_model.dart';
import 'package:svr/app/core/services/ad_manager_service.dart';
import 'package:svr/app/modules/calendario/calendario_repository.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService implements Service {
  static FirebaseRemoteConfig get instance => FirebaseRemoteConfig.instance;

  static const bool useDefaultValues = true;

  @override
  Future<void> initialize() async {
    await instance.setConfigSettings(_configSettings);
    await instance.setDefaults(defaultMap);
    await instance.fetchAndActivate();
  }

  static final RemoteConfigSettings _configSettings = RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(seconds: 30),
  );

  static final Map<String, dynamic> defaultMap = {
    RemoteConfigKey.adConfig: jsonEncode(AdManagerService.config),
    RemoteConfigKey.paymentCalendarNIS:
        jsonEncode(CalendarioRepostory.calendar2023Update),
  };

  static Map<String, dynamic> get adConfig {
    try {
      if (useDefaultValues) return defaultMap[RemoteConfigKey.adConfig];
      log(jsonDecode(instance.getString(RemoteConfigKey.adConfig)).toString());
      return jsonDecode(instance.getString(RemoteConfigKey.adConfig));
    } catch (e) {
      return jsonDecode(defaultMap[RemoteConfigKey.adConfig]);
    }
  }

  static List<List<String>> get calendario {
    try {
      if (useDefaultValues) {
        return CalendarioRepostory.parse(
            defaultMap[RemoteConfigKey.paymentCalendarNIS]);
      }
      return CalendarioRepostory.parse(
          instance.getString(RemoteConfigKey.paymentCalendarNIS));
    } catch (e) {
      return CalendarioRepostory.parse(
          jsonDecode(defaultMap[RemoteConfigKey.paymentCalendarNIS]));
    }
  }
}

class RemoteConfigKey {
  static const String adConfig = 'ad_config';
  static const String paymentCalendarNIS = 'payment_calendar_nis';
}
