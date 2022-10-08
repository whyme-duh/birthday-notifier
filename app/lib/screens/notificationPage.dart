import 'package:app/Widgets/bottomNav.dart';
import 'package:app/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:flutter_local_notifications/flutter_local_notifications.dart";

import '../main.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({Key? key}) : super(key: key);

  @override
  State<MyNotification> createState() => MyNotificationState();
}

class MyNotificationState extends State<MyNotification> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String notificationTitle = "";

  String notificationBody = "";
  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("$deviceToken");
    });
  }

  @override
  void initState() {
    super.initState();
    _getToken();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        notificationTitle = message.notification!.title.toString();
        notificationBody = message.notification!.body.toString();
      });
    });
  }
  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;

  //     // If `onMessage` is triggered with a notification, construct our own
  //     // local notification to show to users using the created channel.
  //     if (notification != null && android != null) {
  //       flutterLocalNotificationsPlugin.show(
  //           notification.hashCode,
  //           notification.title,
  //           notification.body,
  //           NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               channel.id,
  //               channel.name,
  //               // other properties...
  //             ),
  //           ));
  //     }
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       showDialog(
  //           context: context,
  //           builder: (_) {
  //             return AlertDialog(
  //               title: Text('$notification.title'),
  //               content: SingleChildScrollView(
  //                   child: Column(children: [Text('$notification.body')])),
  //             );
  //           });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar:
            CustomButtomNavigationBar(size: size, item: "notification"),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 0,
                  child: Container(
                    height: size.height * 0.1,
                    width: size.width,
                    color: BgColor,
                    child: Center(
                        child: Text(
                      "Notification",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2),
                    )),
                  )),
              Positioned(
                top: size.height * 0.08,
                width: size.width,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Center(
                    child: Container(
                      width: size.width * 0.9,
                      height: size.height * 0.09,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200]),
                      child: Column(
                        children: [
                          Text(notificationTitle),
                          Text(notificationBody),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
