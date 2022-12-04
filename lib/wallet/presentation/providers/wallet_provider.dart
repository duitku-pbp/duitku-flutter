import 'package:duitku/wallet/data/messages/create_transaction_request.dart';
import 'package:duitku/wallet/data/messages/create_wallet_request.dart';
import 'package:duitku/wallet/data/models/report.dart';
import 'package:duitku/wallet/data/models/transaction_group.dart';
import 'package:duitku/wallet/data/models/wallet.dart';
import 'package:duitku/wallet/data/repositories/wallet_repository.dart';
import 'package:duitku/wallet/presentation/states/create_transaction_state.dart';
import 'package:duitku/wallet/presentation/states/create_wallet_state.dart';
import 'package:flutter/foundation.dart';

class WalletProvider with ChangeNotifier {
  final WalletRepository repository;

  List<Wallet> _wallets = [];
  Report? _report;
  List<TransactionGroup> _transactionGroups = [];

  CreateWalletState _createWalletState = CreateWalletInitialState();
  CreateTransactionState _createTransactionState =
      CreateTransactionInitialState();

  WalletProvider({required this.repository});

  List<Wallet> get wallets => _wallets;
  Report? get report => _report;
  List<TransactionGroup> get transactionGroups => _transactionGroups;

  CreateWalletState get createWalletState => _createWalletState;
  CreateTransactionState get createTransactionState => _createTransactionState;

  void resetStates() {
    _createWalletState = CreateWalletInitialState();
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

  Future<void> createWallet({
    required CreateWalletRequest body,
  }) async {
    final res = await repository.createWallet(body: body);
    res.fold(
      (failure) =>
          _createWalletState = CreateWalletFailureState(failure.message),
      (ok) => _createWalletState = CreateWalletOkState(),
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
