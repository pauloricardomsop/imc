import 'dart:convert';

import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/models/app_stream.dart';
import 'package:benefits_brazil/app/core/services/remote_config_service.dart';
import 'package:benefits_brazil/app/core/utils/utils_controller.dart';
import 'package:benefits_brazil/app/modules/splash/splash_model.dart';
import 'package:benefits_brazil/app/modules/splash/splash_repository.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../core/enums/module_enum.dart';

class SplashController {
  static final SplashController _splashController = SplashController._();

  SplashController._();

  factory SplashController() => _splashController;

  final UtilsController _utilsController = UtilsController();

  AppStream<SplashItem> splash = AppStream<SplashItem>();

  List<String> tips =
      jsonDecode(RemoteConfigService.defaultMap[RemoteConfigKey.tips]).cast<String>();

  Future<void> init() async {
    splash.add(SplashItem(await SplashRepository.getTip()));
    FlutterNativeSplash.remove();
    await Future.delayed(const Duration(seconds: 1));
    splash.value.label = 'Atualizando Informações';
    splash.value.progress = 45;
    splash.add(splash.value);
    await Future.delayed(const Duration(seconds: 1));
    splash.value.label = 'Consultando Base de Dados';
    splash.value.progress = 75;
    splash.add(splash.value);
    if (AdController.adConfig.appOpen.active) {
      await Future.delayed(const Duration(seconds: 1));
      splash.value.label = 'Iniciando o App';
      splash.value.progress = 95;
      splash.add(splash.value);
      AdController.fetchOpenedAppAd(AdController.adConfig.appOpen.id);
    } else {
      SplashController().dispose();
    }
  }

  Future<void> dispose() async {   
    splash.value.label = 'App Iniciado';
      splash.value.progress = 100;
      splash.add(splash.value);
    late int tipValue;
    if (splash.value.tip + 1 == tips.length) {
      tipValue = 0;
    } else {
      tipValue = splash.value.tip + 1;
    }
    await SplashRepository.setTip(tipValue);
    _utilsController.moduleStream.add(Module.home);
  }
}
