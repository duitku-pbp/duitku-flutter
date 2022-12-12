import 'package:duitku/wallet/data/messages/create_transaction_request.dart';
import 'package:duitku/wallet/data/messages/create_wallet_request.dart';
import 'package:duitku/wallet/data/models/report.dart';
import 'package:duitku/wallet/data/models/transaction.dart';
import 'package:duitku/wallet/data/models/transaction_group.dart';
import 'package:duitku/wallet/data/models/wallet.dart';
import 'package:duitku/wallet/data/repositories/wallet_repository.dart';
import 'package:duitku/wallet/presentation/bloc/states/create_transaction_state.dart';
import 'package:duitku/wallet/presentation/bloc/states/create_wallet_state.dart';
import 'package:duitku/wallet/presentation/bloc/states/delete_transaction_state.dart';
import 'package:duitku/wallet/presentation/bloc/states/delete_wallet_state.dart';
import 'package:flutter/foundation.dart';

class WalletProvider with ChangeNotifier {
  final WalletRepository repository;

  List<Wallet> _wallets = [];
  Wallet? _wallet;
  Report? _report;
  List<TransactionGroup> _transactionGroups = [];
  Transaction? _transaction;

  CreateWalletState _createWalletState = CreateWalletInitialState();
  CreateTransactionState _createTransactionState =
      CreateTransactionInitialState();
  DeleteWalletState _deleteWalletState = DeleteWalletInitialState();
  DeleteTransactionState _deleteTransactionState =
      DeleteTransactionInitialState();

  WalletProvider({required this.repository});

  List<Wallet> get wallets => _wallets;
  Wallet? get wallet => _wallet;
  Report? get report => _report;
  List<TransactionGroup> get transactionGroups => _transactionGroups;
  Transaction? get transaction => _transaction;

  CreateWalletState get createWalletState => _createWalletState;
  CreateTransactionState get createTransactionState => _createTransactionState;
  DeleteWalletState get deleteWalletState => _deleteWalletState;
  DeleteTransactionState get deleteTransactionState => _deleteTransactionState;

  void resetStates() {
    _createWalletState = CreateWalletInitialState();
    _createTransactionState = CreateTransactionInitialState();
    _deleteWalletState = DeleteWalletInitialState();
    _deleteTransactionState = DeleteTransactionInitialState();

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

  Future<void> getWalletDetail(int walletId) async {
    final res = await repository.getWalletDetail(walletId);
    res.fold(
      (failure) {},
      (wallet) => _wallet = wallet,
    );

    notifyListeners();
  }

  void resetWalletDetail() {
    _wallet = null;
  }

  Future<void> deleteWallet(int walletId) async {
    final res = await repository.deleteWallet(walletId);
    res.fold(
      (failure) =>
          _deleteWalletState = DeleteWalletFailureState(failure.message),
      (ok) => _deleteWalletState = DeleteWalletOkState(),
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

  Future<void> getTransactionDetail(int transactionId) async {
    final res = await repository.getTransactionDetail(transactionId);
    res.fold(
      (failure) {},
      (transaction) => _transaction = transaction,
    );

    notifyListeners();
  }

  void resetTransactionDetail() {
    _transaction = null;
  }

  Future<void> deleteTransaction(int transactionId) async {
    final res = await repository.deleteTransaction(transactionId);
    res.fold(
      (failure) => _deleteTransactionState =
          DeleteTransactionFailureState(failure.message),
      (ok) => _deleteTransactionState = DeleteTransactionOkState(),
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
