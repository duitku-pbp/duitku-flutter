import 'package:duitku/wallet/models/wallet.dart';
import 'package:duitku/wallet/repositories/wallet_repository.dart';
import 'package:flutter/foundation.dart';

class WalletProvider with ChangeNotifier {
  final WalletRepository repository;
  List<Wallet> _wallets = [];

  WalletProvider({required this.repository});

  List<Wallet> get wallets => _wallets;

  Future<void> getWallets() async {
    final res = await repository.getWallets();
    res.fold(
      (failure) => _wallets = [],
      (wallets) => _wallets = [...wallets],
    );

    notifyListeners();
  }
}
