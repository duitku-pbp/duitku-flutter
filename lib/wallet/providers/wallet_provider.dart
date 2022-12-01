import 'package:duitku/wallet/messages/create_transaction_request.dart';
import 'package:duitku/wallet/models/report.dart';
import 'package:duitku/wallet/models/transaction_group.dart';
import 'package:duitku/wallet/models/wallet.dart';
import 'package:duitku/wallet/repositories/wallet_repository.dart';
import 'package:duitku/wallet/states/create_transaction_state.dart';
import 'package:flutter/foundation.dart';

class WalletProvider with ChangeNotifier {
  final WalletRepository repository;

  List<Wallet> _wallets = [];
  Report? _report;
  List<TransactionGroup> _transactionGroups = [];

  CreateTransactionState _createTransactionState =
      CreateTransactionInitialState();

  WalletProvider({required this.repository});

  List<Wallet> get wallets => _wallets;
  Report? get report => _report;
  List<TransactionGroup> get transactionGroups => _transactionGroups;

  CreateTransactionState get createTransactionState => _createTransactionState;

  void resetStates() {
    _createTransactionState = CreateTransactionInitialState();

    notifyListeners();
  }

  Future<void> getWallets() async {
    final res = await repository.getWallets();
    res.fold(
      (failure) => _wallets = [],
      (wallets) => _wallets = [...wallets],
    );

    notifyListeners();
  }

  Future<void> getReport(String period) async {
    final res = await repository.getReport(period);
    res.fold(
      (failure) {},
      (report) => _report = report,
    );

    notifyListeners();
  }

  Future<void> getTransactions([
    String wallet = "all",
  ]) async {
    final res = await repository.getTransactions(wallet);
    res.fold(
      (failure) {},
      (trxGroups) => _transactionGroups = trxGroups,
    );

    notifyListeners();
  }

  Future<void> createTransaction({
    required CreateTransactionRequest body,
  }) async {
    final res = await repository.createTransaction(body: body);
    res.fold(
      (failure) => _createTransactionState =
          CreateTransactionFailureState(failure.message),
      (ok) => _createTransactionState = CreateTransactionOkState(),
    );

    notifyListeners();
  }
}
