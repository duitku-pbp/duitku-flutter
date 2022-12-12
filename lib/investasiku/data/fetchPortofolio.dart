import 'package:duitku/investasiku/data/portofolioModels.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Portofolio>> fetchPortofolio() async {
  
  var url = Uri.parse('https://duitku.nairlangga.com/investasiku/json/portofolio/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object ToDo
  List<Portofolio> listWatch = [];

  for (var d in data) {
    if (d != null) {
      listWatch.add(Portofolio.fromJson(d));
    }
  }
  return listWatch;
}
