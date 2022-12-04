import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:duitku/auth/data/messages/login_request.dart';
import 'package:duitku/auth/data/repositories/auth_repository.dart';
import 'package:duitku/auth/presentation/states/login_state.dart';
import 'package:duitku/common/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final SharedPreferences prefs;
  final CookieJar jar;
  final AuthRepository repository;

  String? _sessionId;

  LoginState _loginState = LoginInitialState();

  AuthProvider({
    required this.prefs,
    required this.jar,
    required this.repository,
  });

  String? get sessionId => _sessionId;
  bool get isAuthenticated => _sessionId != null;

  LoginState get loginState => _loginState;

  Future<void> init() async {
    final uri = Uri.parse(baseUrl);

    final sessionId = prefs.getString("sessionid");
    final csrfToken = prefs.getString("csrftoken");
    if (sessionId != null && sessionId.isNotEmpty) {
      _sessionId = sessionId;

      await jar.saveFromResponse(uri, [Cookie("sessionid", sessionId)]);
    }

    await jar.saveFromResponse(uri, [Cookie("csrftoken", csrfToken ?? "")]);
  }

  Future<void> login({required LoginRequest body}) async {
    final res = await repository.login(body: body);
    res.fold(
      (failure) => _loginState = LoginFailureState(failure.message),
      (sessionId) {
        _sessionId = sessionId;
        _loginState = LoginOkState();
      },
    );

    notifyListeners();
  }

  Future<void> logout() async {
    await repository.logout();
    _sessionId = null;

    notifyListeners();
  }
}
