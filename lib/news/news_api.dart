import 'dart:convert';
//import 'dart:html';
import 'package:duitku/news/news_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

// class newsAPI -> disini adalah tempat untuk memanggil API dan parameter API ditulis
class NewsApi {
  static Future<List<News>> getNews() async {
    var uri = Uri.https('bb-finance.p.rapidapi.com', "/stories/list",
        {"id": "usdjpy", "template": "CURRENCY"});
    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "3e0c82d23dmsh8aa923431107b2ap12db5fjsn66d8d6d8a8cc",
      "x-rapidapi-host": "bb-finance.p.rapidapi.com"
    });

    // untuk menandakan apakah API berhasil mengambil data atau tidak

    Map data = jsonDecode(response.body);

    List temp = [];

    for (var i in data['stories']) {
      //debugPrint(News.fromJson(i).title);
      temp.add(i);
    }

    return News.newsFromSnapshot(temp);
  }
}

