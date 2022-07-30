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
      body: SafeArea(
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              child: Container(
                height: size.height * 0.12,
                width: size.width,
                color: BgColor,
                child: Center(
                    child: Text(
                  "Daily Horoscope",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2),
                )),
              )),
          Positioned(
            left: 0,
            top: size.height * 0.09,
            right: 0,
            height: size.height * 0.8,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: ListView.builder(
                itemCount: sunSign.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<String>(
                    future: getHorosocope(sunSign[index]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Container(
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
                        );
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
          // Positioned(
          //     bottom: 0,
          //     child: CustomButtomNavigationBar(size: size, item: "horoscope"))
        ]),
      ),
    );
  }
}
