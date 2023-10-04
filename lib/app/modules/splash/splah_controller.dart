import 'package:ad_manager/ad_manager.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:svr/app/core/models/service_model.dart';
import 'package:svr/app/core/utils/utils_controller.dart';

import '../../core/enums/module_enum.dart';
import 'splash_model.dart';

class SplashController {
  static final SplashController _splashController = SplashController._();

  SplashController._();

  factory SplashController() => _splashController;

  final UtilsController _utilsController = UtilsController();

  AppStream<SplashItem> splash = AppStream<SplashItem>();

  Future<void> init(Function onDispose) async {
    splash.add(SplashItem());
    FlutterNativeSplash.remove();
    await Future.delayed(const Duration(seconds: 1));
    splash.value.label = 'Atualizando Informações';
    splash.value.progress = 45;
    splash.update();
    await Future.delayed(const Duration(seconds: 1));
    splash.value.label = 'Consultando Base de Dados';
    splash.value.progress = 75;
    splash.update();
    await Service.initAplicationServices();
    if (AdManager.instance.config.appOpen.active) {
      await Future.delayed(const Duration(seconds: 1));
      splash.value.label = 'Iniciando o App';
      splash.value.progress = 95;
      splash.update();
      AdManager.showAppOpen(onDispose: onDispose);
    } else {
      SplashController().dispose();
    }
  }

  Future<void> dispose() async {
    splash.value.label = 'App Iniciado';
    splash.value.progress = 100;
    splash.update();
    _utilsController.moduleStream.add(Module.home);
  }

  void onEntrar() {
    splash.value.label = 'entrando no app';
    splash.value.progress = 99;
    splash.update();
  }
}
