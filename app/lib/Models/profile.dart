import 'package:app/API/getHoroscopeAPI.dart';
import 'package:app/Auth/AuthService.dart';
import 'package:app/Widgets/bottomNav.dart';
import 'package:app/functionality/friendlist.dart';
import 'package:app/screens/editprofile.dart';
import 'package:app/screens/horoscopeFinder.dart';
import 'package:app/screens/settings.dart';
import 'package:app/testing/tst.dart';
import 'package:app/wrapper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../Widgets/appbar.dart';
import '../shared/constants.dart';

import 'package:app/Auth/AuthService.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String email = '';
  String zodiac = '';
  String age = '';
  String remTime = '';
  String horoscope = '';

  var formated_dob = '';

  Future _getUserData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!['username'];
          email = snapshot.data()!['email'];
          zodiac = HoroscopeFinder(snapshot.data()!['dob']);
          age = ProfileAgeDifffernce(snapshot.data()!['dob']);
          remTime = RemainingDaysForBirthday(snapshot.data()!['dob']);

          // DateTime retrievedDob = DateTime.parse(dob);
          // formated_dob = DateFormat("yyyy-MM-dd").format(retrievedDob);
        });
        horoscope = await getHorosocope(zodiac.toString());
      }
    });
  }

  AuthService _auth = AuthService();
  FirebaseAuth _authenicate = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  // signOut() async {
  //   try {
  //     BuildContext context = Wrapper() as BuildContext;
  //     await _authenicate.signOut();
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => Wrapper()));
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: CustomButtomNavigationBar(
        size: size,
        item: "profile",
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                top: 0,
                child: Container(
                  height: size.height * 0.1,
                  width: size.width,
                  color: BgColor,
                  child: Center(
                      child: Text(
                    "My Profile",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2),
                  )),
                )),
            Positioned(
              top: size.height * 0.08,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: BgColor.withOpacity(0.5),
                            child: CircleAvatar(
                              radius: 50,
                              child: Image(
                                  image:
                                      AssetImage('assets/icon/user-icon.png')),
                            ),
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              Text(name,
                                  style: GoogleFonts.acme(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          letterSpacing: 1))),
                              SizedBox(height: 10),
                              Text(email,
                                  style: GoogleFonts.acme(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 72, 70, 70),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w200,
                                          letterSpacing: 1)))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 2,
                            width: size.width * 0.9,
                            color: Colors.black.withOpacity(0.15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RowDetail(
                                  upperText: zodiac,
                                  lowerText: "Zodian Sign",
                                ),
                                RowDetail(
                                  upperText: remTime,
                                  lowerText: "Remaing Time for Birthday",
                                ),
                                RowDetail(
                                  upperText: age,
                                  lowerText: "Age",
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FutureBuilder<Object>(
                              future: getHorosocope(zodiac),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    width: size.width * 0.9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        color: Colors.blue[50]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "My Horoscope",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18,
                                                letterSpacing: 2),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          AutoSizeText(
                                            '${snapshot.data}',
                                            maxFontSize: 20,
                                            maxLines: 20,
                                            style: TextStyle(
                                                fontSize: 15, letterSpacing: 2),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: SpinKitCircle(
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  );
                                }
                              }),
                          SizedBox(
                            height: 30,
                          ),
                          ProfileOptionCard(
                            size: size,
                            iconfirst: Icon(Icons.edit),
                            title: "Edit Profile",
                            option: "profile",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ProfileOptionCard(
                            size: size,
                            iconfirst: Icon(Icons.settings),
                            title: "Settings",
                            option: "settings",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ProfileOptionCard(
                            size: size,
                            iconfirst: Icon(Icons.logout),
                            title: "Logout",
                            option: "logout",
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class RowDetail extends StatelessWidget {
  final String upperText;
  final String lowerText;
  const RowDetail({
    Key? key,
    required this.upperText,
    required this.lowerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(upperText,
            style: GoogleFonts.lato(
                textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.black,
            ))),
        SizedBox(
          height: 5,
        ),
        Text(
          lowerText,
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: WhiteFontColor)),
        )
      ],
    );
  }
}

class ProfileOptionCard extends StatelessWidget {
  final String title;
  final Icon iconfirst;
  final String option;

  const ProfileOptionCard({
    Key? key,
    required this.size,
    required this.title,
    required this.iconfirst,
    required this.option,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();

    return InkWell(
      onTap: () async {
        if (option == "logout") {
          await _auth.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Wrapper()));
        } else if (option == "settings") {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => SettingsPage())));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => (EditProfile()))));
        }
      },
      child: Container(
          width: size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 246, 239, 239)),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconfirst,
                Text(title,
                    style:
                        GoogleFonts.lato(textStyle: TextStyle(fontSize: 20))),
                Icon(
                  Icons.arrow_right,
                )
              ],
            ),
          )),
    );
  }
}
