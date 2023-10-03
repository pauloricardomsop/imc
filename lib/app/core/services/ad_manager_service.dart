import 'package:ad_manager/ad_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:log_manager/log_manager.dart';
import 'package:svr/app/app_controller.dart';
import 'package:svr/app/core/models/service_model.dart';
import 'package:svr/app/modules/splash/ui/splash_page.dart';

class AdManagerService implements Service {
  @override
  Future<void> initialize() async {
    if (AdManager.instance.isInitialized) return;
    await MobileAds.instance.initialize();
    await MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
        testDeviceIds: ['E5050E013B8198CA09DA8ED5AB922238']));
    await AdManager.instance.initialize(
      json: config,
      navigatorKey: AppController().key,
      onSplash: (_, onDispose) => SplashPage(onDispose),
      log: LogManager.instance,
      firebaseMenssaging: FirebaseMessaging.instance,
    );
  }

  static final Map<String, dynamic> config = {
    "activeAll": true,
    "appOpen": {
      "active": false,
      "idIOS": "ca-app-pub-8419654969814276/7184142484",
      "idAndroid": "ca-app-pub-8419654969814276/4927579039",
    },
    "banner": {
      "active": true,
      "idIOS": "ca-app-pub-8419654969814276/7291953690",
      "idAndroid": "ca-app-pub-8419654969814276/1971523182",
    },
    "intersticial": {
      "active": false,
      "idIOS": "ca-app-pub-8419654969814276/3520229645",
      "idAndroid": "ca-app-pub-8419654969814276/6721888307",
    },
    "rewarded": {
      "active": false,
      "idIOS": "ca-app-pub-8419654969814276/5978872021",
      "idAndroid": "ca-app-pub-8419654969814276/5856363345",
    }
  };
}
