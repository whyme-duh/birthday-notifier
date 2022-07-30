import 'package:app/Auth/AuthService.dart';
import 'package:app/Widgets/bottomNav.dart';
import 'package:app/functionality/friendlist.dart';
import 'package:app/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/appbar.dart';
import '../shared/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: CustomButtomNavigationBar(
        size: size,
        item: "profile",
      ),
      appBar: AppBar(
          backgroundColor: BgColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Your Profile",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 2),
          )),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: 0,
              child: Container(
                height: size.height * 0.2,
                width: size.width,
                color: BgColor,
              )),
          Positioned(
            top: size.height * 0.02,
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
                            image: AssetImage('assets/icon/user-icon.png')),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Ritik Lal Shrestha ",
                        style: GoogleFonts.acme(
                            textStyle:
                                TextStyle(fontSize: 15, letterSpacing: 1))),
                    SizedBox(
                      height: 30,
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
                          horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RowDetail(
                            upperText: "Leo",
                            lowerText: "Zodian Sign",
                          ),
                          RowDetail(
                            upperText: "14",
                            lowerText: "Friends",
                          ),
                          RowDetail(
                            upperText: "23",
                            lowerText: "Age",
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
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
            ),
          ),
        ],
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Wrapper()));
        } else if (option == "settings") {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => FriendList())));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => FriendList())));
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
