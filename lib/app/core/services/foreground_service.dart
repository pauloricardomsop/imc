import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/enums/module_enum.dart';
import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/core/utils/utils_controller.dart';
import 'package:svr/app/modules/splash/ui/splash_page.dart';

class ForegroundService {
  static AppStream<bool> foregroundStream = AppStream.seed(true);

  static bool showForegroundBack = false;
  static bool appReturnFromWebExec = false;

  static listen() {
    foregroundStream.add(true);
    FGBGEvents.stream.listen((fg) async {
      foregroundStream.add(fg == FGBGType.foreground);
      if (fg == FGBGType.foreground) {
        if (appReturnFromWebExec) {
          appReturnFromWebExec = false;
          return;
        }
        if (showForegroundBack) {
          UtilsController().moduleStream.add(Module.splash);
          push(contextGlobal, const SplashPage());
          AdController.fetchOpenedAppAd(AdController.adConfig.appOpen.id, fromBackground: true);
        }
      }
    });
  }
}
