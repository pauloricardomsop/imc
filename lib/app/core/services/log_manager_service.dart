import 'package:svr/app/core/models/service_model.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:kochava_tracker/kochava_tracker.dart';
import 'package:log_manager/log_manager.dart';

class LogManagerService implements Service {
  @override
  Future<void> initialize() async {
    await FacebookAppEvents().setAutoLogAppEventsEnabled(true);
    await FacebookAppEvents().setAdvertiserTracking(enabled: true);

    KochavaTracker.instance.registerAndroidAppGuid("ko-1-svr-qbw");
    KochavaTracker.instance.start();

    LogManager.instance.initialize(
      facebookAppEvents: FacebookAppEvents(),
      firebaseAnalytics: FirebaseAnalytics.instance,
      kochavaTracker: KochavaTracker.instance,
    );
  }
}
