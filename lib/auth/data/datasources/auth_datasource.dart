import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:duitku/auth/data/messages/login_request.dart';
import 'package:duitku/common/constants.dart';
import 'package:duitku/common/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthDatasource {
  final http.Client client;
  final CookieJar jar;
  final SharedPreferences prefs;

  AuthDatasource({
    required this.client,
    required this.jar,
    required this.prefs,
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

  Future<void> login({required LoginRequest body}) async {
    await _setCsrfToken();

    final uri = Uri.parse("$baseUrl/authentication/login/");
    final cookies = await jar.loadForRequest(uri);
    final csrfToken = await _getCsrfToken();
    final cookieStr = cookies.join(" ").replaceAll(" HttpOnly", "");

    final req = http.MultipartRequest("POST", uri);
    req.headers.addAll({"Cookie": cookieStr, "X-CSRFTOKEN": csrfToken});
    req.fields.addAll(body.toJson());
    final res = await client.send(req);

    if (res.statusCode == 302) {
      final sessionId =
          res.headers["set-cookie"]?.split("sessionid=")[1].split(";")[0];

      if (sessionId == null || sessionId.isEmpty) {
        throw HttpException("Failed to login");
      }

      await jar.saveFromResponse(
        Uri.parse(baseUrl),
        [Cookie("sessionid", sessionId)],
      );
      await prefs.setString("sessionid", sessionId);
      return;
    }

    throw HttpException("Failed to login");
  }

  Future<void> logout() async {
    final uri = Uri.parse("$baseUrl/authentication/logout/");
    await client.get(uri);

    await jar.delete(Uri.parse(baseUrl));
    await prefs.remove("sessionid");
    await prefs.remove("csrftoken");
  }
}
