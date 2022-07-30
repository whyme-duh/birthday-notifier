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
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("$deviceToken");
    });
  }

  @override
  void initState() {
    super.initState();
    _getToken();
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
        appBar: AppBar(
          centerTitle: true,
          title: Text("Notification",
              style: GoogleFonts.alegreya(
                textStyle: TextStyle(
                    fontSize: 20,
                    letterSpacing: 2,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
              )),
          backgroundColor: BgColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Stack(
          children: <Widget>[
            Center(
                child: Text("No Notification Yet",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                      fontSize: 15,
                    )
                        //   flutterLocalNotificationsPlugin.show(
                        //       0,
                        //       "Try",
                        //       "Hello",
                        //       NotificationDetails(
                        //           android: AndroidNotificationDetails(
                        //               channel.id, channel.name,
                        //               importance: Importance.max)));
                        // },

                        )))
          ],
        ));
  }
}
