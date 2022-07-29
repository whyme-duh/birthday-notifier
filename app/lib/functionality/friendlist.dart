import 'package:app/Auth/AuthService.dart';
import 'package:app/Database/detailDB.dart';
import 'package:app/Models/profile.dart';
import 'package:app/functionality/function(adding).dart';
import 'package:app/screens/detail.dart';
import 'package:app/screens/horoscopeFinder.dart';
import 'package:app/screens/notificationPage.dart';
import 'package:app/shared/constants.dart';
import 'package:app/testing/tst.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../Widgets/bottomNav.dart';
import '../Widgets/drawer.dart';

class FriendList extends StatefulWidget {
  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  var NameController = MaskTextInputFormatter(
      mask: '################', filter: {"#": RegExp(r'[A-Z a-z]')});
  var DateController = MaskTextInputFormatter(
      mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});
  // var id = Uuid();
  // final String NameId = id.v1();

  AuthService user = AuthService();

  DetailDB _detailDb = DetailDB(collectionName: "asdf");

  String name = "";
  String date = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool hasInternet = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BgColor,
      key: _scaffoldKey,
      bottomNavigationBar: CustomButtomNavigationBar(size: size, item: "home"),
      drawer: DrawerMethods(),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            height: 150,
            width: size.width,
            child: Container(
              width: size.width,
              height: size.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Good Morning, Ritik",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 2),
                                ),
                              ),
                            ],
                          ),
                          // IconButton(
                          //     onPressed: () {
                          //       _scaffoldKey.currentState?.openDrawer();
                          //     },
                          //     icon: Icon(Icons.menu_outlined)),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  addDialog(
                                    context,
                                  );
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
                              // IconButton(
                              //     onPressed: () {
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) =>
                              //                   MyNotification()));
                              //     },
                              //     icon: Icon(Icons.settings_outlined))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 120,
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
                    return SpinKitFadingCircle(
                      color: Colors.black,
                    );
                  }
                  return Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
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
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () async {
                                // Future horoscope = getHorosocope(
                                //     HoroscopeFinder(document['Date'])
                                //         .toString());
                                hasInternet = await InternetConnectionChecker()
                                    .hasConnection;
                                if (hasInternet) {
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
                                } else {
                                  Fluttertoast.showToast(
                                    msg:
                                        "No Internet Connection! Try again later.",
                                  );
                                }
                              },
                              child: Container(
                                  width: size.width * 0.9,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: cardColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                    255, 219, 219, 219)
                                                .withOpacity(0.55),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(document['Name'],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w900,
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
                  );
                }),
          ),
        ],
      ),
    );
  }
}
