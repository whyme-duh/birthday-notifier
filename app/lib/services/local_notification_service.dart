import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// this file is used for creating notification channel

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _plugin.initialize(initializationSettings,
        onSelectNotification: (String? route) async {
      print(route);
      if (route != null) {
        Navigator.of(context).pushNamed(route);
      }
    });
  }

  //this function is used to display notification pannel when the app is in foreground
  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "easyapproach", "easyapproach channel",
              importance: Importance.max, priority: Priority.high));

      await _plugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: message.data["route"]);
    } catch (e) {
      print(e.toString());
    }
  }
}
