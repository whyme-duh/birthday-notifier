import 'package:app/Models/profile.dart';
import 'package:app/functionality/friendlist.dart';
import 'package:app/screens/notificationPage.dart';
import 'package:flutter/material.dart';

import '../screens/horoscopeFinder.dart';

class CustomButtomNavigationBar extends StatefulWidget {
  String item;
  CustomButtomNavigationBar({
    Key? key,
    required this.size,
    required this.item,
  }) : super(key: key);

  final Size size;

  @override
  State<CustomButtomNavigationBar> createState() =>
      _CustomButtomNavigationBarState();
}

class _CustomButtomNavigationBarState extends State<CustomButtomNavigationBar> {
  bool homeActive = false;

  bool horoscopeActive = false;

  bool profileActive = false;

  bool notificationActive = false;

  void initState() {
    if (widget.item == "home") {
      homeActive = true;
    } else if (widget.item == "horoscope") {
      horoscopeActive = true;
    } else if (widget.item == "profile") {
      profileActive = true;
    } else if (widget.item == "notification") {
      notificationActive = true;
    } else {
      homeActive = false;
      horoscopeActive = false;
      profileActive = false;
      notificationActive = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
      child: Container(
        width: widget.size.height,
        height: widget.size.height * 0.08,
        decoration: BoxDecoration(
            color: Color.fromARGB(15, 185, 183, 182).withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            //home icone
            IconButton(
              icon: Icon(homeActive ? Icons.home : Icons.home_outlined),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => FriendList()));
              },
            ),
            // horoscope Icon
            IconButton(
              icon: Icon(horoscopeActive ? Icons.list : Icons.list_outlined),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Horoscope()));
              },
            ),
            // notification
            IconButton(
              icon: Icon(notificationActive
                  ? Icons.notifications
                  : Icons.notifications_outlined),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyNotification()));
              },
            ),
            //profile
            IconButton(
              icon: Icon(profileActive ? Icons.person : Icons.person_outline),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
