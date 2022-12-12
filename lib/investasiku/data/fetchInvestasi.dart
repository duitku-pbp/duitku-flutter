import 'package:http/http.dart' as http;
import 'dart:convert';
import 'investasiModels.dart';
import 'dart:convert';
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
Future<Investasi> fetchInvestasiId(int i) async {
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

  Investasi invest = Investasi(pk: -1, investment_name: "null", investment_type: "null", cagr_1Y: "null", drawdown_1Y: "null", aum: "null", expense_ratio: "null", min_buy: 0);
  for (var d in data) {
    if (d != null) {
      Investasi invest = Investasi.fromJson(d);
      if(invest.pk == i){
        return invest;
      }
    }
  }

  return invest;
}