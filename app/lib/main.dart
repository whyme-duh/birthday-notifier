import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app/Auth/AuthService.dart';
import 'package:app/functionality/friendlist.dart';
import 'package:app/screens/notificationPage.dart';
import 'package:app/screens/splash.dart';
import 'package:app/services/local_notification_service.dart';
import 'package:app/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'Models/user.dart';

// is used when app is in background
Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  // this part is for the splash screen
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initialization(null);
  FlutterNativeSplash.remove();
  runApp(Notifier());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 2));
}

class Notifier extends StatefulWidget {
  const Notifier({Key? key}) : super(key: key);

  @override
  _NotifierState createState() => _NotifierState();
}

class _NotifierState extends State<Notifier> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalNotificationService.initialize(context);

    //gives the message on which use taps
    //and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      final routeMessage = message!.data['route'];
      Navigator.of(context).pushNamed(routeMessage);
    });

    // when the app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      // uses to display the pannel
      LocalNotificationService.display(message);
    });

    // it must be in background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeMessage = message.data['route'];
      Navigator.of(context).pushNamed(routeMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserProfile?>.value(
      initialData: null,
      catchError: (_, __) => null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        // home: AnimatedSplashScreen(
        //   duration: 2000,
        //   splashTransition: SplashTransition.fadeTransition,

        //   splash: Icon(Icons.abc_rounded),
        //   nextScreen: Wrapper(),
        // ),
      ),
    );
  }
}
