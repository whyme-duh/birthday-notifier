import 'package:app/Auth/AuthService.dart';
import 'package:app/Models/profile.dart';
import 'package:app/functionality/function(adding).dart';
import 'package:app/screens/agefinder.dart';
import 'package:app/screens/detail.dart';
import 'package:app/screens/horoscopeFinder.dart';
import 'package:app/shared/constants.dart';
import 'package:app/testing/tst.dart';
import 'package:app/widget.dart/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class FriendList extends StatefulWidget {
  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  final AuthService _auth = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool hasInternet = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
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
            DrawerMethods(title: "PROFILE", link: ProfilePage()),
            DrawerMethods(title: "AGE FINDER", link: AgeFinder()),
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
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            height: 200,
            width: size.width,
            child: Container(
              width: size.width,
              height: size.height * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35)),
                  color: BgColor),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              onPressed: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              icon: Icon(Icons.menu_outlined)),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  addDialog(context);
                                },
                                child: Container(
                                  width: 80,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    color: btnColor,
                                  ),
                                  child: Center(child: Text("Add")),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.notifications_on_outlined))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text("Birthday Notifier",
                        style: GoogleFonts.alegreya(
                          textStyle: TextStyle(
                              fontSize: 30,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w900),
                        ))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 180,
            left: 0,
            height: size.height,
            width: size.width,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("collectionName")
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width,
                      child: ListView(
                        children: snapshot.data!.docs.map((document) {
                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              width: 100,
                              color: Colors.red,
                              child: Center(
                                child: Icon(Icons.delete),
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async {
                              deleteDialog(context, document);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  // Future horoscope = getHorosocope(
                                  //     HoroscopeFinder(document['Date'])
                                  //         .toString());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                                name: document['Name'],
                                                dob: document['Date'],
                                                age: AgeDifffernce(
                                                    document['Date']),
                                                remDays:
                                                    RemainingDaysForBirthday(
                                                        document['Date']),
                                                zodiac: HoroscopeFinder(
                                                        document['Date'])
                                                    .toString(),
                                              )));
                                },
                                child: Container(
                                    width: size.width * 0.9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[200],
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.15),
                                              spreadRadius: 1,
                                              blurRadius: 10,
                                              offset: Offset(5, 8))
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(document['Name'],
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      letterSpacing: 2,
                                                    )),
                                                birthdayOrNot(document['Date'])
                                                    ? Icon(Icons.cake_outlined)
                                                    : Text(""),
                                                Text(RemainingDaysForBirthday(
                                                    document['Date']))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ));
                }),
          ),
        ],
      ),
    );
  }
}
