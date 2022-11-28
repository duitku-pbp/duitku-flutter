import 'package:duitku/common/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class AuthProvider with ChangeNotifier {
  String? _sessionId;
  final IOClient client;

  AuthProvider({required this.client});

  bool get isAuthenticated {
    return _sessionId != null;
  }

  Future<String> getCsrfToken({required Uri uri}) async {
    final res = await client.get(uri);
    return res.headers["set-cookie"]?.split(";")[0].split("=")[1] ?? "";
  }

  Future<void> signIn({
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

    _sessionId =
        res.headers["set-cookie"]?.split("sessionid=")[1].split(";")[0];

    notifyListeners();
  }
}
