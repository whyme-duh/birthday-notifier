import 'package:app/API/getHoroscopeAPI.dart';
import 'package:app/Auth/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../Models/profile.dart';
import '../screens/horoscopeFinder.dart';

class DrawerMethods extends StatelessWidget {
  final AuthService _auth = AuthService();

  DrawerMethods({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: Image(
              image: AssetImage('assets/icon/ic_launcher.jpeg'),
              width: 1000,
              height: 150,
            ),
          ),
          ListTile(
            title: InkWell(
              onTap: () async {
                // SystemNavigator.pop();
                await _auth.signOut();
              },
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Text("FAVCOURITES",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                        ))),
              )),
            ),
          ),
          ListTile(
            title: InkWell(
              onTap: () async {
                hasInternet = await InternetConnectionChecker().hasConnection;
                if (hasInternet) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Horoscope()));
                } else {
                  Fluttertoast.showToast(
                      msg: "Error! You need internet connection");
                }
                // Fluttertoast.showToast(
                //     msg: "This feature is not working properly right now!");
                // Navigator.pop(context);
              },
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Text("HOROSCOPES",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                        ))),
              )),
            ),
          ),
          ListTile(
            title: InkWell(
              onTap: () async {
                // SystemNavigator.pop();
                await _auth.signOut();
              },
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Text("LOGOUT",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                        ))),
              )),
            ),
          )
        ],
      ),
    );
  }
}
