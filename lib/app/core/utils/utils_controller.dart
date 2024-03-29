import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svr/app/core/models/app_stream.dart';

class UtilsController {
  static final UtilsController _utilsController = UtilsController._();

  UtilsController._();

  factory UtilsController() => _utilsController;

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  final AppStream<bool> ignoringStream = AppStream<bool>.seed(false);

  final AppStream<String> toastStream = AppStream<String>.seed('');

  final showOnboarding = AppStream<bool>();

  Future<void> getShowOnboarding() async {
    final instance = await SharedPreferences.getInstance();
    final showOnboarding = instance.getBool('showOnboarding');
    if (showOnboarding == null) {
      instance.setBool('showOnboarding', true);
    }
    _utilsController.showOnboarding.add(showOnboarding ?? true);
  }

  Future<void> setShowOnboarding(bool value) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setBool('showOnboarding', value);
    await getShowOnboarding();
  }
}
