import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:log_manager/log_manager.dart';
import 'package:svr/app/app_controller.dart';
import 'package:svr/app/core/models/service_model.dart';

class AdManagerService implements Service {
  @override
  Future<void> initialize() async {
    if (AdManager.instance.isInitialized) return;
    await MobileAds.instance.initialize();
    // await MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
    //     testDeviceIds: ['E5050E013B8198CA09DA8ED5AB922238']));
    await AdManager.instance.initialize(
      json: config,
      navigatorKey: AppController().key,
      onLoading: (_, __) => LoadingPage.open((_) => __.call()),
      log: LogManager.instance,
      firebaseMenssaging: FirebaseMessaging.instance,
    );
  }

  static final Map<String, dynamic> config = {
    "activeAll": true,
    "appOpen": {
      "active": true,
      // "idIOS": "ca-app-pub-8419654969814276/7184142484",
      "idIOS": "ca-app-pub-3940256099942544/1033173712",
      "idAndroid": "ca-app-pub-8419654969814276/4927579039",
    },
    "banner": {
      "active": false,
      "idIOS": "ca-app-pub-8419654969814276/7291953690", 
      "idAndroid": "ca-app-pub-8419654969814276/6666047983",
    },
    "intersticial": {
      "active": true,
      "idIOS": "ca-app-pub-8419654969814276/3520229645",
      "idAndroid": "ca-app-pub-8419654969814276/6721888307",
    },
    "rewarded": {
      "active": true,
      "idIOS": "ca-app-pub-8419654969814276/5978872021",
      "idAndroid": "ca-app-pub-8419654969814276/5856363345",
    }
  };
}
