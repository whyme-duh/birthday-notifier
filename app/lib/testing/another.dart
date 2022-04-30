import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';

Future<String> getHorosocope(String sign) async {
  try {
    String main_url =
        await "https://devbrewer-horoscope.p.rapidapi.com/today/short/${sign}";
    Response res = await get(Uri.parse(main_url), headers: {
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
