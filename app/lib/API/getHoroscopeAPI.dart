import 'dart:convert';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Map horoscopeList = {};
bool hasInternet = false;

Future<String> getHorosocope(String sign) async {
  try {
    String mainUrl =
        "https://devbrewer-horoscope.p.rapidapi.com/today/short/$sign";
    Response res = await get(Uri.parse(mainUrl), headers: {
      'X-RapidAPI-Host': 'devbrewer-horoscope.p.rapidapi.com',
      'X-RapidAPI-Key': '15f0dba1b2mshcb0f9e851acb94bp1d2886jsn4c99a5146b84'
    });
    Map detail = jsonDecode(res.body);
    horoscopeList.addAll({'${detail['$sign']}': '${detail['Today']}'});
    // print(horoscopeList);
    // print('\n');
    if (hasInternet = await InternetConnectionChecker().hasConnection) {
      return detail['$sign']['Today'];
    }
    return "No internet! Try again ";
  } catch (e) {
    return "Error occured! Try again.";
  }
}

void main() {
  print(horoscopeList);
}

Future<String> getLoveMatching(String sign) async {
  try {
    String mainUrl =
        "https://devbrewer-horoscope.p.rapidapi.com/today/short/$sign";
    Response res = await get(Uri.parse(mainUrl), headers: {
      'X-RapidAPI-Host': 'devbrewer-horoscope.p.rapidapi.com',
      'X-RapidAPI-Key': '15f0dba1b2mshcb0f9e851acb94bp1d2886jsn4c99a5146b84'
    });
    Map detail = jsonDecode(res.body);
    return detail['Matchs']['Love'];
  } catch (e) {
    return e.toString();
  }
}
