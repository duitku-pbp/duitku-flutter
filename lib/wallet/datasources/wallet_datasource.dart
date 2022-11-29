import 'dart:convert';

import 'package:duitku/common/constants.dart';
import 'package:duitku/common/exceptions.dart';
import 'package:duitku/wallet/messages/get_wallet_response.dart';
import 'package:duitku/wallet/models/wallet.dart';
import 'package:http/http.dart' as http;

class WalletDatasource {
  final http.Client client;

  WalletDatasource({required this.client});

  Future<List<Wallet>> getWallets() async {
    final uri = Uri.parse("$baseUrl/wallet/api/");
    final res = await client.get(uri);

    if (res.statusCode == 200) {
      return GetWalletResponse.fromJson(json.decode(res.body)).wallets;
    } else {
      throw HttpException();
    }
  }
}
