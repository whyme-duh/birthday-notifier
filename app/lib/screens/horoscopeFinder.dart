import 'package:app/API/getHoroscopeAPI.dart';
import 'package:app/functionality/function(adding).dart';
import 'package:app/widget.dart/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
      appBar: TopBar(
          appBar: AppBar(),
          Icons: Icon(Icons.add),
          func: () {
            addDialog(context);
          },
          Heading: Text("HOROSCOPE")),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
          child: Container(
            height: 50,
            color: Colors.grey[100],
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Today Date : ',
                      style: TextStyle(fontSize: 15, letterSpacing: 2)),
                  Text('$date-$month-$day',
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
        ),
        Padding(
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
                                color: Colors.grey[100]),
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
      ]),
    );
  }
}
