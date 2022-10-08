import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: BgColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Settings",
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
              child: Center(child: Text("Settings")),
            ),
          ),
        ],
      ),
    );
  }
}
