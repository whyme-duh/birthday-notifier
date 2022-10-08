import 'package:app/API/getHoroscopeAPI.dart';
import 'package:app/Database/detailDB.dart';
import 'package:app/Widgets/bottomNav.dart';
import 'package:app/functionality/function(adding).dart';
import 'package:app/functionality/updating.dart';
import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({
    Key? key,
    required this.name,
    required this.dob,
    required this.zodiac,
    required this.age,
    required this.remDays,
  }) : super(key: key);

  final String name;
  final String dob;
  final String zodiac;
  final String age;
  final String remDays;

  DetailDB _detailDb = DetailDB();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar:
            CustomButtomNavigationBar(size: size, item: "profile"),
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          // centerTitle: true,
          // title: Text(
          //   name,
          //   style: GoogleFonts.alegreya(
          //     textStyle: TextStyle(
          //         fontSize: 25,
          //         letterSpacing: 1,
          //         color: Colors.black,
          //         fontWeight: FontWeight.w700),
          //   ),
          // ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // updateDialog(context);
                    Fluttertoast.showToast(msg: "Opss! Not Now!");
                  },
                  child: Container(
                    width: 80,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Color.fromRGBO(122, 118, 118, 0.2),
                    ),
                    child: Center(
                        child: InkWell(
                      onTap: () {
                        Fluttertoast.showToast(msg: "Opss! Not Now!");
                      },
                      child: Text(
                        "Edit",
                        style: TextStyle(color: Colors.black),
                      ),
                    )),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {
                      Fluttertoast.showToast(msg: "Opss! Not Now!");
                    },
                    icon: Icon(
                      Icons.favorite,
                    ))
              ],
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              height: 30,
              width: size.width,
              child: Container(
                width: size.width,
                height: size.height * 0.1,
                color: BgColor,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              width: size.width,
              height: size.height,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.only(
                      //     topLeft: Radius.circular(30),
                      //     topRight: Radius.circular(30)),
                      color: Colors.white),
                  child: FutureBuilder(
                      future: getHorosocope(zodiac),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return SpinKitCircle(color: Colors.black);
                        }
                        return Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(name,
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 25,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                      )),
                                  Container(
                                    width: size.width,
                                    height: 1,
                                    color: Color.fromARGB(255, 138, 138, 138),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SideTitle(title: "DOB : ", date: dob),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SideTitle(
                                      title: "Zodiac Sign : ", date: zodiac),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SideTitle(
                                    title: "Age : ",
                                    date: age,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SideTitle(
                                      title: "Next Birthday :", date: remDays),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                    width: size.width * 0.9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        color: Colors.blue[50]),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Horoscope",
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
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            )
          ],
        ));
  }
}

class SideTitle extends StatelessWidget {
  String title;
  String date;
  SideTitle({
    required this.title,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        AutoSizeText(
          date,
          maxLines: 10,
        ),
      ],
    );
  }
}
