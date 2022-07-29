import 'package:app/API/getHoroscopeAPI.dart';
import 'package:app/Widgets/bottomNav.dart';
import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  print(getHorosocope("Cancer"));
}

class Horoscope extends StatefulWidget {
  const Horoscope({Key? key}) : super(key: key);

  @override
  _HoroscopeState createState() => _HoroscopeState();
}

class _HoroscopeState extends State<Horoscope> {
  List<String> sunSign = [
    "Aries",
    "Taurus",
    "Gemini",
    "Cancer",
    "Leo",
    "Virgo",
    "Libra",
    "Scorpio",
    "Sagittarius",
    "Capricon",
    "Aquarius",
    "Pisces",
  ];

  final date = DateTime.now().year;
  final month = DateTime.now().month;
  final day = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar:
          CustomButtomNavigationBar(size: size, item: "horoscope"),
      appBar: AppBar(
        backgroundColor: BgColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          height: size.height * 0.15,
          width: size.width,
          child: Container(
            width: size.width,
            height: size.height * 0.15,
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
                  Text("Daily Horoscope",
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
          left: 0,
          top: size.height * 0.1,
          right: 0,
          height: size.height * 0.8,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Expanded(
              child: ListView.builder(
                itemCount: sunSign.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<String>(
                    future: getHorosocope(sunSign[index]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 203, 226, 238)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${sunSign[index]}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 2),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${snapshot.data}',
                                      style: TextStyle(letterSpacing: 2),
                                    )
                                  ],
                                ),
                              )),
                        ));
                      } else {
                        return SpinKitChasingDots(
                          size: 10,
                          color: Colors.black,
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
