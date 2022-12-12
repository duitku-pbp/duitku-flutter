import 'package:http/http.dart' as http;
import 'dart:convert';
import 'investasi_models.dart';
import 'dart:async';

Future<List<Investasi>> fetchInvestasi() async {
  var url = Uri.parse('https://duitku.nairlangga.com/investasiku/json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object MyWatchList
  List<Investasi> listInvestasi = [];
  for (var d in data) {
    if (d != null) {
      listInvestasi.add(Investasi.fromJson(d));
    }
  }

  return listInvestasi;
}
