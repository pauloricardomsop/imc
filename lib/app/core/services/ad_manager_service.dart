import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/app_controller.dart';
import 'package:svr/app/core/models/service_model.dart';
import 'package:svr/app/modules/splash/ui/splash_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:log_manager/log_manager.dart';

class AdManagerService implements Service {
  @override
  Future<void> initialize() async {
    if (AdManager.instance.isInitialized) return;
    await MobileAds.instance.initialize();
    await AdManager.instance.initialize(
      json: config,
      navigatorKey: AppController().key,
      onSplash: (_, onDispose) => SplashPage(onDispose),
      log: LogManager.instance,
      firebaseMenssaging: FirebaseMessaging.instance,
    );
  }

  static final Map<String, dynamic> config = {
    "activeAll": false,
    "appOpen": {
      "active": true,
      "mode": "waterfall",
      "idsIOS": [],
      "idsAndroid": [
        'ca-app-pub-8419654969814276/4869133355',
        'ca-app-pub-8419654969814276/7656198350',
        'ca-app-pub-8419654969814276/5179306302',
        'bidding:ca-app-pub-8419654969814276/4927579039',
      ]
    },
    "banner": {
      "active": true,
      "mode": "waterfall",
      "idsIOS": [],
      "idsAndroid": [
        'ca-app-pub-8419654969814276/3284604853',
        'ca-app-pub-8419654969814276/3727457981',
        'ca-app-pub-8419654969814276/1971523182',
        'bidding:ca-app-pub-8419654969814276/6666047983',
      ]
    },
    "intersticial": {
      "active": true,
      "mode": "waterfall",
      "idsIOS": [],
      "idsAndroid": [
        'ca-app-pub-8419654969814276/7512728125',
        'ca-app-pub-8419654969814276/7033930567',
        'ca-app-pub-8419654969814276/8405069592',
        'bidding:ca-app-pub-8419654969814276/6721888307',
      ]
    },
    "rewarded": {
      "active": true,
      "mode": "waterfall",
      "idsIOS": [],
      "idsAndroid": [
        'ca-app-pub-8419654969814276/9018103605',
        'ca-app-pub-8419654969814276/8853671820',
        'ca-app-pub-8419654969814276/4520455392',
        'bidding:ca-app-pub-8419654969814276/5856363345',
      ]
    }
  };
}