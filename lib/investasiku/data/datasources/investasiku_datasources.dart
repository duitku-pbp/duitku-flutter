import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:duitku/common/exceptions.dart';
import 'package:duitku/investasiku/data/portofolio_models.dart';
import 'package:duitku/investasiku/data/messages/get_wallet_response.dart';
import 'package:http/http.dart' as http;

class PortofolioDataSources {
  final http.Client client;
  final CookieJar jar;

  PortofolioDataSources({
    required this.client,
    required this.jar,
  });

  Future<List<Portofolio>> fetchPortofolio() async {
    final uri = Uri.parse("https://duitku.nairlangga.com/investasiku/json/portofolio/");
    final cookies = await jar.loadForRequest(uri);
    final sessionId = cookies.where((c) => c.name == "sessionid").join();
    final res = await client.get(
      uri,
      headers: {"Cookie": sessionId.toString()},
    );

    if (res.statusCode == 200) {
      return GetPortofolioResponse.fromJson(json.decode(res.body)).portofolio;
    }

    throw HttpException();
  }
  
}
