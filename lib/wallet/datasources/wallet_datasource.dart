import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:duitku/common/constants.dart';
import 'package:duitku/common/exceptions.dart';
import 'package:duitku/wallet/messages/create_transaction_request.dart';
import 'package:duitku/wallet/messages/get_report_response.dart';
import 'package:duitku/wallet/messages/get_transactions_response.dart';
import 'package:duitku/wallet/messages/get_wallet_response.dart';
import 'package:duitku/wallet/models/report.dart';
import 'package:duitku/wallet/models/transaction_group.dart';
import 'package:duitku/wallet/models/wallet.dart';
import 'package:http/http.dart' as http;

class WalletDatasource {
  final http.Client client;
  final CookieJar jar;

  WalletDatasource({
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
    }

    throw HttpException();
  }

  Future<Report> getReport(String period) async {
    final uri = Uri.parse("$baseUrl/wallet/api/report/$period");
    final cookies = await jar.loadForRequest(uri);
    final sessionId = cookies.where((c) => c.name == "sessionid").join();

    final res = await client.get(
      uri,
      headers: {"Cookie": sessionId.toString()},
    );

    if (res.statusCode == 200) {
      return GetReportResponse.fromJson(json.decode(res.body)).report;
    }

    throw HttpException();
  }

  Future<List<TransactionGroup>> getTransactions([
    String wallet = "all",
  ]) async {
    final uri =
        Uri.parse("$baseUrl/wallet/api/transaction/?from-wallet=$wallet");
    final cookies = await jar.loadForRequest(uri);
    final sessionId = cookies.where((c) => c.name == "sessionid").join();

    final res = await client.get(
      uri,
      headers: {"Cookie": sessionId.toString()},
    );

    if (res.statusCode == 200) {
      return GetTransactionsResponse.fromJson(
        json.decode(res.body),
      ).transactionGroups;
    }

    throw HttpException();
  }

  Future<void> createTransaction({
    required CreateTransactionRequest body,
  }) async {
    await _setCsrfToken();

    final uri = Uri.parse("$baseUrl/wallet/api/transaction/create/");
    final cookies = (await jar.loadForRequest(uri)).join(" ");

    final res = await client.post(
      uri,
      body: json.encode(body.toJson()),
      headers: {"Cookie": cookies},
    );

    if (res.statusCode == 301) {
      return;
    }

    throw HttpException();
  }
}
