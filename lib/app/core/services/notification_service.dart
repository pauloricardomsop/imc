import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/services/foreground_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class NotificationService {
  static void negative(
    String label,
  ) =>
      ScaffoldMessenger.of(contextGlobal).showSnackBar(
        SnackBar(
          // backgroundColor: AppColors.red,
          content: Text(
            label,
            //TODO
            // style: AppTheme.text.bodyText1!.copyWith(
            //   color: Colors.white,
            // ),
          ),
        ),
      );
  static void positive(
    String label,
  ) =>
      ScaffoldMessenger.of(contextGlobal).showSnackBar(
        SnackBar(
          // backgroundColor: AppColors.green,
          content: Text(
            label,
            //TODO
            // style: AppTheme.text.bodyText1!.copyWith(
            //   color: Colors.white,
            // ),
          ),
        ),
      );
  static void neutral(
    String label,
  ) =>
      ScaffoldMessenger.of(contextGlobal).showSnackBar(
        SnackBar(
          // backgroundColor: AppColors.greenDark,
          content: Text(
            label,
            //TODO
            // style: AppTheme.text.bodyText1!.copyWith(
            //   color: Colors.white,
            // ),
          ),
        ),
      );
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

String? urlToShow;

Future<void> initFirebaseMessaging() async {
  FirebaseMessaging.instance.subscribeToTopic('scheduled_notification');
  FirebaseMessaging.onMessage.listen(showFlutterNotification);
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    ForegroundService.showForegroundBack = true;
    urlToShow = message.data['url'];
  });
  setupFlutterNotifications();
}

Future<void> setupFlutterNotifications() async {
  channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: AndroidInitializationSettings('ic_notification')),
      onSelectNotification: selectNotificationInForeground);
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'ic_notification',
        ),
      ),
      payload: message.data['url'],
    );
  }
}

void handleInitialMessage(RemoteMessage? message) {
  if (message == null) return;
  execUrl(message.data['url']);
}

Future selectNotificationInForeground(String? payload) async =>
    AdController.showInsterticialAdNotification(AdController.adConfig.intersticial.id, payload!);
