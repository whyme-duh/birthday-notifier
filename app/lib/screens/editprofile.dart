import 'package:app/Auth/AuthService.dart';
import 'package:app/Widgets/bottomNav.dart';
import 'package:app/functionality/friendlist.dart';
import 'package:app/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/appbar.dart';
import '../shared/constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
