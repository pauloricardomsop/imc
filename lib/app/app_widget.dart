import 'package:svr/app/core/components/module_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'app_controller.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppController _appController = AppController();

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        color: const Color(0xFF082F49),
        debugShowCheckedModeBanner: false,
        navigatorKey: _appController.key,
        title: 'SVR - Valores a Receber',
        theme: appTheme,
        home: const ModulePage(),
      ),
    );
  }
}
