import 'package:ad_manager/ad_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:svr/app/core/models/service_model.dart';
import 'package:svr/app/core/utils/utils_controller.dart';

import 'core/enums/module_enum.dart';

class AppController {
  static final AppController _instance = AppController._();

  AppController._();

  factory AppController() => _instance;

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  BuildContext get context => key.currentState!.context;

  bool isInitialized = false;
  Future<void> initialize() async {
    if(isInitialized) return;
    isInitialized = true;
    FlutterNativeSplash.remove();
    await Service.initAplicationServices();
    if (AdManager.instance.config.appOpen.active) {
      AdManager.showAppOpen(onDispose: () => UtilsController().moduleStream.add(Module.home));
    } else {
      UtilsController().moduleStream.add(Module.home);
    }
  }

}
