import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:duitku/common/constants.dart';
import 'package:duitku/common/exceptions.dart';
import 'package:duitku/wallet/data/messages/create_transaction_request.dart';
import 'package:duitku/wallet/data/messages/create_wallet_request.dart';
import 'package:duitku/wallet/data/messages/get_report_response.dart';
import 'package:duitku/wallet/data/messages/get_transaction_detail_response.dart';
import 'package:duitku/wallet/data/messages/get_transactions_response.dart';
import 'package:duitku/wallet/data/messages/get_wallet_detail_response.dart';
import 'package:duitku/wallet/data/messages/get_wallet_response.dart';
import 'package:duitku/wallet/data/models/report.dart';
import 'package:duitku/wallet/data/models/transaction.dart';
import 'package:duitku/wallet/data/models/transaction_group.dart';
import 'package:duitku/wallet/data/models/wallet.dart';
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

  Future<String> _getCsrfToken() async {
    final cookies = await jar.loadForRequest(Uri.parse(baseUrl));

    return cookies
        .firstWhere(
          (c) => c.name == "csrftoken",
          orElse: () => Cookie("csrftoken", ""),
        )
        .value;
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

  Future<Wallet> getWalletDetail(int walletId) async {
    final uri = Uri.parse("$baseUrl/wallet/api/$walletId/");
    final cookies = await jar.loadForRequest(uri);
    final sessionId = cookies.where((c) => c.name == "sessionid").join();

    final res = await client.get(uri, headers: {"Cookie": sessionId});

    if (res.statusCode == 200) {
      return GetWalletDetailResponse.fromJson(json.decode(res.body)).wallet;
    }

    throw HttpException("Failed to get wallet");
  }

  Future<void> deleteWallet(int walletId) async {
    await _setCsrfToken();
    final uri = Uri.parse("$baseUrl/wallet/api/$walletId/");
    final cookies = await jar.loadForRequest(uri);
    final csrfToken = await _getCsrfToken();
    final cookieStr = cookies.join(" ").replaceAll(" HttpOnly", "");

    final res = await client.delete(
      uri,
      headers: {"Cookie": cookieStr, "X-CSRFTOKEN": csrfToken},
    );

    if (res.statusCode == 302) {
      return;
    }

    throw HttpException("Failed to delete wallet");
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

  Future<Transaction> getTransactionDetail(int transactionId) async {
    final uri = Uri.parse("$baseUrl/wallet/api/transaction/$transactionId/");
    final cookies = await jar.loadForRequest(uri);
    final sessionId = cookies.where((c) => c.name == "sessionid").join();

    final res = await client.get(uri, headers: {"Cookie": sessionId});

    if (res.statusCode == 200) {
      return GetTransactionDetailResponse.fromJson(
        json.decode(res.body),
      ).transaction;
    }

    throw HttpException("Failed to get wallet");
  }

  Future<void> deleteTransaction(int transactionId) async {
    await _setCsrfToken();
    final uri = Uri.parse("$baseUrl/wallet/api/transaction/$transactionId/");
    final cookies = await jar.loadForRequest(uri);
    final csrfToken = await _getCsrfToken();
    final cookieStr = cookies.join(" ").replaceAll(" HttpOnly", "");

    final res = await client.delete(
      uri,
      headers: {"Cookie": cookieStr, "X-CSRFTOKEN": csrfToken},
    );

    if (res.statusCode == 302) {
      return;
    }

    throw HttpException("Failed to delete transaction");
  }

  Future<void> createWallet({
    required CreateWalletRequest body,
  }) async {
    await _setCsrfToken();

    final uri = Uri.parse("$baseUrl/wallet/api/create/");
    final cookies = await jar.loadForRequest(uri);
    final csrfToken = await _getCsrfToken();
    final cookieStr = cookies.join(" ").replaceAll(" HttpOnly", "");

    final res = await client.post(
      uri,
      body: json.encode(body.toJson()),
      headers: {"Cookie": cookieStr, "X-CSRFTOKEN": csrfToken},
    );

    if (res.statusCode == 302) {
      return;
    }

    throw HttpException("Failed to create wallet");
  }

  Future<void> createTransaction({
    required CreateTransactionRequest body,
  }) async {
    await _setCsrfToken();

    final uri = Uri.parse("$baseUrl/wallet/api/transaction/create/");
    final cookies = await jar.loadForRequest(uri);
    final csrfToken = await _getCsrfToken();
    final cookieStr = cookies.join(" ").replaceAll(" HttpOnly", "");

    final res = await client.post(
      uri,
      body: json.encode(body.toJson()),
      headers: {"Cookie": cookieStr, "X-CSRFTOKEN": csrfToken},
    );

    if (res.statusCode == 302) {
      return;
    }

    throw HttpException(json.decode(res.body)["message"] ?? "An error occured");
  }
}
