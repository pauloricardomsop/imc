import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:svr/app/modules/home/home_page.dart';

import 'app_controller.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppController _appController = AppController();

  @override
  void initState() {
    _appController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      supportedLocales: const [Locale('pt'), Locale('en'), Locale('es')],
      child: OverlaySupport(
        child: Builder(builder: (context) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            color: const Color(0xFFF8FAFC),
            debugShowCheckedModeBanner: false,
            navigatorKey: _appController.key,
            title: 'title'.tr(),
            home: const HomePage(),
          );
        }),
      ),
    );
  }
}
