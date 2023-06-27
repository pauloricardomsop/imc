import 'dart:ui';

// import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:svr/app/app_controller.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/enums/module_enum.dart';
import 'package:svr/app/core/services/foreground_service.dart';
import 'package:svr/app/core/services/remote_config_service.dart';
import 'package:svr/app/core/services/route_service.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/utils_controller.dart';

Future<void> initializeServices() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  await Firebase.initializeApp();
  await RemoteConfigService.init();
  // initFirebaseMessaging();
  // await setupFlutterNotifications();
  await ForegroundService.listen();
  await initializeDateFormatting('pt_BR');
  //TODO
  // await FacebookAppEvents().setAutoLogAppEventsEnabled(true);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppController _appController = AppController();

  @override
  void initState() {
    super.initState();
    MobileAds.instance.initialize().then((value) {
      if (AdController.adConfig.appOpen.active) {
        AdController.fetchOpenedAppAd(AdController.adConfig.appOpen.id);
      } else {
        UtilsController().moduleStream.add(Module.home);
      }
    });
    AdController.fetchBanner(AdController.adConfig.banner.id, AdController.adBannerStorage);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _appController.key,
      title: 'Valores a Receber',
      theme: AppTheme.theme,
      initialRoute: RouteService.initial,
      routes: RouteService.routes,
    );
  }
}
