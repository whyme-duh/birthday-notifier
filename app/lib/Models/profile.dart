import 'package:app/Widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/appbar.dart';

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
      appBar: TopBar(
        appBar: AppBar(),
        Icons: Icon(Icons.settings_outlined),
        Heading: Text("PROFILE"),
        func: () {
          print("a");
        },
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              width: size.width,
              height: size.height * 0.20,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/icon/icon.png'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                        width: size.width * 0.2,
                        height: size.height * 0.03,
                        color: Colors.blue[100],
                        alignment: Alignment.center,
                        child: Text("CHANGE"))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.23,
            right: 0,
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: size.height * 0.55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey),
                      right: BorderSide(width: 1.0, color: Colors.grey),
                      left: BorderSide(width: 1.0, color: Colors.grey),
                      bottom: BorderSide(width: 1.0, color: Colors.grey),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    Text(
                      "NAME",
                      style: GoogleFonts.abhayaLibre(
                          textStyle: TextStyle(fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "RITIK LAL SHRESTHA",
                        style: GoogleFonts.aclonica(
                            textStyle: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "DATE OF BIRTH",
                        style: GoogleFonts.abhayaLibre(
                            textStyle: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "1999-07-31",
                        style: GoogleFonts.aclonica(
                            textStyle: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "HOROSCOPES",
                        style: GoogleFonts.abhayaLibre(
                            textStyle: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "1999-07-31",
                        style: GoogleFonts.aclonica(
                            textStyle: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
