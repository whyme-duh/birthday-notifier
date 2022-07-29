import 'package:http/http.dart';
import 'dart:convert';

Future<String> getHorosocope(String sign) async {
  try {
    String mainUrl =
        "https://devbrewer-horoscope.p.rapidapi.com/today/short/$sign";
    Response res = await get(Uri.parse(mainUrl), headers: {
      'X-RapidAPI-Host': 'devbrewer-horoscope.p.rapidapi.com',
      'X-RapidAPI-Key': '15f0dba1b2mshcb0f9e851acb94bp1d2886jsn4c99a5146b84'
    });
    Map detail = jsonDecode(res.body);
    return detail['$sign']['Today'];
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}

void main() async {
  print(await getHorosocope("Cancer"));
}
