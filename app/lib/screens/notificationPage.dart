import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({Key? key}) : super(key: key);

  @override
  State<MyNotification> createState() => MyNotificationState();
}

class MyNotificationState extends State<MyNotification> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Notification",
              style: GoogleFonts.alegreya(
                textStyle: TextStyle(
                    fontSize: 20,
                    letterSpacing: 2,
                    color: WhiteFontColor,
                    fontWeight: FontWeight.w900),
              )),
          backgroundColor: BgColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: size.width,
              height: size.height * 0.025,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35)),
                  color: BgColor),
            )
          ],
        ));
  }
}
