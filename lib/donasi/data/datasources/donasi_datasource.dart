import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:duitku/common/constants.dart';
import 'package:duitku/common/exceptions.dart';
import 'package:duitku/donasi/data/messages/get_donasi_response.dart';
import 'package:duitku/donasi/data/messages/add_donasi_request.dart';
import 'package:duitku/donasi/data/models/donasi.dart';
import 'package:http/http.dart' as http;

class DonasiDatasource {
  final http.Client client;
  final CookieJar jar;

  DonasiDatasource({
    required this.client,
    required this.jar,
  });

  Future<void> _setCsrfToken() async {
    final uri = Uri.parse("$baseUrl/authentication/login/");

    final res = await client.get(uri);
    final csrfToken =
        res.headers["set-cookie"]?.split(";")[0].split("=")[1] ?? "";

    await jar.saveFromResponse(
      Uri.parse(baseUrl),
      [Cookie("csrftoken", csrfToken)],
    );
  }

  Future<String> _getCsrfToken() async {
    final cookies = await jar.loadForRequest(Uri.parse(baseUrl));

    return cookies
        .firstWhere(
          (c) => c.name == "csrftoken",
          orElse: () => Cookie("csrftoken", ""),
        )
        .value;
  }
  Future<List<Donasi>> getDonasi() async {
    final uri = Uri.parse("$baseUrl/donasi/show-json/");
    final cookies = await jar.loadForRequest(uri);
    final sessionId = cookies.where((c) => c.name == "sessionid").join();

    final res = await client.get(
      uri,
      headers: {"Cookie": sessionId.toString()},
    );
    
    if (res.statusCode == 200) {
      return GetDonasiResponse.fromJson(json.decode(res.body)).donasis;
    }
    throw HttpException();
  }

  Future<void> addDonasi({
    required AddDonasiRequest body,
  }) async {
    await _setCsrfToken();

    final uri = Uri.parse("$baseUrl/donasi/add/");
    final cookies = await jar.loadForRequest(uri);
    final csrfToken = await _getCsrfToken();
    final cookieStr = cookies.join(" ").replaceAll(" HttpOnly", "");

    final res = await client.post(
      uri,
      body: json.encode({...body.toJson(), "date": DateTime.now()}),
      headers: {"Cookie": cookieStr, "X-CSRFTOKEN": csrfToken},
    );
    if (res.statusCode == 302) {
      return;
    }

    throw HttpException("Failed to add donasi");
  }
}