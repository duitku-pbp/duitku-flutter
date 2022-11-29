import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:duitku/common/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _sessionId;
  final http.Client client;
  final CookieJar jar;

  AuthProvider({
    required this.client,
    required this.jar,
  });

  bool get isAuthenticated {
    return _sessionId != null;
  }

  String? get sessionId => _sessionId;

  Future<String> getCsrfToken({required Uri uri}) async {
    final res = await client.get(uri);
    final csrfToken =
        res.headers["set-cookie"]?.split(";")[0].split("=")[1] ?? "";

    await jar.saveFromResponse(
      Uri.parse(baseUrl),
      [Cookie("csrftoken", csrfToken)],
    );

    return csrfToken;
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final uri = Uri.parse("$baseUrl/authentication/login/");
    final csrftoken = await getCsrfToken(uri: uri);

    final req = http.MultipartRequest('POST', uri);
    req.fields.addAll({"username": username, "password": password});
    req.headers.addAll({"X-CSRFTOKEN": csrftoken});
    req.headers.addAll({"Cookie": "csrftoken=$csrftoken;"});
    final res = await client.send(req);

    String? oldSessionId = _sessionId;
    _sessionId =
        res.headers["set-cookie"]?.split("sessionid=")[1].split(";")[0];

    if (oldSessionId != _sessionId) {
      final cookies = [Cookie("sessionid", _sessionId ?? "")];
      jar.saveFromResponse(Uri.parse(baseUrl), cookies);

      notifyListeners();
    }
  }

  Future<void> logout() async {
    final uri = Uri.parse("$baseUrl/authentication/logout/");
    await client.get(uri);

    _sessionId = null;
    await jar.delete(Uri.parse(baseUrl));

    notifyListeners();
  }
}
