import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:app/screens/horoscopeFinder.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

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
    return "Error occured! Try again.";
  }
}

Future<String> getLoveMatching(String sign) async {
  try {
    String main_url =
        await "https://devbrewer-horoscope.p.rapidapi.com/today/short/${sign}";
    Response res = await get(Uri.parse(main_url), headers: {
      'X-RapidAPI-Host': 'devbrewer-horoscope.p.rapidapi.com',
      'X-RapidAPI-Key': '15f0dba1b2mshcb0f9e851acb94bp1d2886jsn4c99a5146b84'
    });
    Map detail = jsonDecode(res.body);
    return detail['Matchs']['Love'];
  } catch (e) {
    return e.toString();
  }
}
