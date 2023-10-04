import 'dart:convert';
import 'dart:developer';
import 'package:svr/app/core/models/service_model.dart';
import 'package:svr/app/core/services/ad_manager_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:svr/app/modules/estatisticas/estatisticas_model.dart';

class RemoteConfigService implements Service {
  static FirebaseRemoteConfig get instance => FirebaseRemoteConfig.instance;

  static const bool useDefaultValues = true;

  @override
  Future<void> initialize() async {
    await instance.setConfigSettings(_configSettings);
    await instance.setDefaults(defaultMap);
    await instance.fetchAndActivate();
    _setValues();
  }

    static void _setValues() {
    EstatisticasValores.estatisticasValores = estatisticasValores;
  }

  static final RemoteConfigSettings _configSettings = RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(seconds: 30),
  );

  static final Map<String, dynamic> defaultMap = {
    RemoteConfigKey.adConfig: jsonEncode(AdManagerService.config),
    RemoteConfigKey.valores: jsonEncode(EstatisticasValores.defaultMap),
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

  static EstatisticasValores get estatisticasValores {
    try {
      if (useDefaultValues) {
        return EstatisticasValores.fromJson(
            jsonDecode(defaultMap[RemoteConfigKey.valores]));
      }
      return EstatisticasValores.fromJson(
          jsonDecode(instance.getString(RemoteConfigKey.valores)));
    } catch (e) {
      return EstatisticasValores.fromJson(
          jsonDecode(defaultMap[RemoteConfigKey.valores]));
    }
  }

}

class RemoteConfigKey {
  static const String adConfig = 'ad_config';
  static const String valores = 'valores';
}
