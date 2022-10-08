import 'package:app/Models/profile.dart';
import 'package:app/functionality/friendlist.dart';
import 'package:app/screens/notificationPage.dart';
import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: widget.size.width,
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
              icon:
                  Icon(horoscopeActive ? Icons.sunny : Icons.wb_sunny_outlined),
              onPressed: () async {
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     backgroundColor: Colors.red,
                //     content: Container(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text("Error has occured! Try again later."),
                //           InkWell(
                //             onTap: () {
                //               ScaffoldMessenger.of(context).clearSnackBars();
                //             },
                //             child: Icon(Icons.close_rounded),
                //           )
                //         ],
                //       ),
                //     )));
                var hasInternet =
                    await InternetConnectionChecker().hasConnection;
                if (hasInternet) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Horoscope()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Container(
                      padding: EdgeInsets.all(16),
                      height: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Stack(children: [
                        Positioned(
                            top: -5,
                            child: InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ))),
                        Positioned(
                          top: 10,
                          left: 0,
                          right: 0,
                          child: Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.error_rounded,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    "Error! No Internet",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.w500),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Color.fromARGB(255, 240, 238, 238),
                  ));
                }
              },
            ),
            // notification
            IconButton(
              icon: Icon(notificationActive
                  ? Icons.notifications
                  : Icons.notifications_outlined),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("This feature is under development."),
                          InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).clearSnackBars();
                            },
                            child: Icon(Icons.close_rounded),
                          )
                        ],
                      ),
                    )));
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => MyNotification()));
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
