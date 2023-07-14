import 'dart:convert';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/core/services/remote_config_service.dart';
import 'package:svr/app/core/utils/utils_controller.dart';
import 'package:svr/app/modules/splash/splash_model.dart';
import 'package:svr/app/modules/splash/splash_repository.dart';

import '../../core/enums/module_enum.dart';

class SplashController {
  static final SplashController _splashController = SplashController._();

  SplashController._();

  factory SplashController() => _splashController;

  final UtilsController _utilsController = UtilsController();

  AppStream<SplashItem> splash = AppStream<SplashItem>();

  List<String> tips =
      jsonDecode(RemoteConfigService.defaultMap[RemoteConfigKey.tips]).cast<String>();

  Future<void> init(Function onDispose) async {
    splash.add(SplashItem(await SplashRepository.getTip()));
    FlutterNativeSplash.remove();
    await Future.delayed(const Duration(seconds: 1));
    splash.value.label = 'Atualizando Informações';
    splash.value.progress = 45;
    splash.update();
    await Future.delayed(const Duration(seconds: 1));
    splash.value.label = 'Consultando Base de Dados';
    splash.value.progress = 75;
    splash.update();
    if (AdController.adConfig.appOpen.active) {
      await Future.delayed(const Duration(seconds: 1));
      splash.value.label = 'Iniciando o App';
      splash.value.progress = 95;
      splash.update();
      AdController.fetchOpenedAppAd(AdController.adConfig.appOpen.id);
      () => onDispose();
    } else {
      SplashController().dispose();
    }
  }

  Future<void> dispose() async {
    splash.value.label = 'App Iniciado';
    splash.value.progress = 100;
    splash.update();
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
