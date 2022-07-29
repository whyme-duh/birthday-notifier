import 'package:app/Auth/AuthService.dart';
import 'package:app/functionality/friendlist.dart';
import 'package:app/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'Models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Notifier());
}

class Notifier extends StatefulWidget {
  const Notifier({Key? key}) : super(key: key);

  @override
  _NotifierState createState() => _NotifierState();
}

class _NotifierState extends State<Notifier> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserProfile?>.value(
      initialData: null,
      catchError: (_, __) => null,
      value: AuthService().user,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/wrapper",
          routes: {
            "/wrapper": (context) => Wrapper(),
          }),
    );
  }
}
