import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:duitku/common/constants.dart';
import 'package:duitku/common/exceptions.dart';
import 'package:duitku/wallet/messages/get_wallet_response.dart';
import 'package:duitku/wallet/models/wallet.dart';
import 'package:http/http.dart' as http;

class WalletDatasource {
  final http.Client client;
  final CookieJar jar;

  WalletDatasource({
    required this.client,
    required this.jar,
  });

  Future<List<Wallet>> getWallets() async {
    final uri = Uri.parse("$baseUrl/wallet/api/");
    final cookies = await jar.loadForRequest(uri);
    final sessionId = cookies.where((c) => c.name == "sessionid").join();

    final res = await client.get(
      uri,
      headers: {"Cookie": sessionId.toString()},
    );

    if (res.statusCode == 200) {
      return GetWalletResponse.fromJson(json.decode(res.body)).wallets;
    } else {
      throw HttpException();
    }
  }
}
