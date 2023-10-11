import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:svr/app/core/models/service_model.dart';

class AppController {
  static final AppController _instance = AppController._();

  AppController._();

  factory AppController() => _instance;

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  BuildContext get context => key.currentState!.context;

  bool isInitialized = false;
  Future<void> onInit() async {
    if (isInitialized) return;
    isInitialized = true;
    FlutterNativeSplash.remove();
    await Service.initAplicationServices();
  }
}
