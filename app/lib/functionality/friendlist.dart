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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../Widgets/bottomNav.dart';
import '../Widgets/drawer.dart';

class FriendList extends StatefulWidget {
  // final uid;

  // const FriendList({Key? key,required this.uid}) : super(key: key);

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

  DetailDB _detailDb = DetailDB();

  String username = "";
  String name = '';

  String date = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool hasInternet = false;

  Stream<QuerySnapshot> getUserInputSnapshot(BuildContext context) async* {
    final uid = await _auth.getUserUID();
    yield* FirebaseFirestore.instance
        .collection("UserData")
        .doc(uid)
        .collection("FriendList")
        .snapshots();
  }

  Future _getUserData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          username = snapshot.data()!['username'];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      // key: _scaffoldKey,
      bottomNavigationBar: CustomButtomNavigationBar(size: size, item: "home"),
      // drawer: DrawerMethods(),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                width: size.width,
                color: BgColor,
                height: size.height * 0.12,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilePage()));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.person),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Hello! " + username + ",",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 2),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  hoverColor: Colors.red,
                                  onTap: () {
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                              padding: EdgeInsets.all(20),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Add Your Friend's Birthday",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              letterSpacing: 2,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                            "NOTE: PROPER DATE TO BE PROVIDED.",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                letterSpacing:
                                                                    2)),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Form(
                                                              key: _formKey,
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  TextFormField(
                                                                    validator:
                                                                        (val) {
                                                                      if (val!
                                                                          .isEmpty) {
                                                                        return "The field cant be empty";
                                                                      }
                                                                    },
                                                                    textCapitalization:
                                                                        TextCapitalization
                                                                            .words,
                                                                    onChanged:
                                                                        (val) {
                                                                      name =
                                                                          val;
                                                                    },
                                                                    inputFormatters: [
                                                                      NameController
                                                                    ],
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      hintText:
                                                                          "Name",
                                                                      labelText:
                                                                          "Friend's Name",
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  TextFormField(
                                                                    inputFormatters: [
                                                                      DateController
                                                                    ],
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .datetime,
                                                                    validator:
                                                                        (val) {
                                                                      if (val!
                                                                          .isEmpty) {
                                                                        return "The field cant be empty";
                                                                      }
                                                                    },
                                                                    onChanged:
                                                                        (val) {
                                                                      date =
                                                                          val;
                                                                    },
                                                                    decoration: InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        hintText:
                                                                            "YYYY-MM-DD",
                                                                        labelText:
                                                                            "Date Of Birth"),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              TextButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                            Colors.red),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                    "CANCEL",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                              TextButton(
                                                                  style: ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all(Colors
                                                                              .lightBlue)),
                                                                  onPressed:
                                                                      () async {
                                                                    String uid =
                                                                        await _auth
                                                                            .getUserUID();
                                                                    AgeDifffernce(
                                                                        date);
                                                                    birthdayOrNot(
                                                                        date);
                                                                    RemainingDaysForBirthday(
                                                                        date);
                                                                    if (NameController.getMaskedText() != null &&
                                                                        DateController.getMaskedText() !=
                                                                            null &&
                                                                        _formKey
                                                                            .currentState!
                                                                            .validate() &&
                                                                        validateDate(
                                                                            date)) {
                                                                      _detailDb.takeDetail(
                                                                          uid,
                                                                          name,
                                                                          date);
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg: "DETAIL HAS BEEN ADDED");
                                                                      Navigator.pop(
                                                                          context);
                                                                    } else {
                                                                      await Fluttertoast
                                                                          .showToast(
                                                                              msg: "DETAIL YOU HAVE PROVIDED IS INCORRECT");
                                                                      Navigator.pop(
                                                                          context);
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    "ADD",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ))
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ]));
                                        });
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
              top: size.height * 0.09,
              bottom: 0,
              width: size.width,
              child: StreamBuilder(
                  stream: getUserInputSnapshot(context),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return SpinKitFadingCircle(
                        color: Colors.black,
                      );
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            )),
                        child: ListView(
                          children: snapshot.data!.docs.map((document) {
                            print(document['Name']);
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
                                    hasInternet =
                                        await InternetConnectionChecker()
                                            .hasConnection;
                                    if (hasInternet) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
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
                                  child: Center(
                                    child: Container(
                                        width: size.width * 0.9,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: cardColor,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color.fromARGB(
                                                          255, 219, 219, 219)
                                                      .withOpacity(0.55),
                                                  spreadRadius: 1,
                                                  blurRadius: 10,
                                                  offset: Offset(5, 3))
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                                    birthdayOrNot(
                                                            document['Date'])
                                                        ? Icon(
                                                            Icons.cake_outlined)
                                                        : Text(""),
                                                    Text(
                                                        RemainingDaysForBirthday(
                                                            document['Date']))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
