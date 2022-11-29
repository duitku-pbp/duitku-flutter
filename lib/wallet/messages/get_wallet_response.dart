import 'package:duitku/wallet/models/wallet.dart';

class GetWalletResponse {
  final List<Wallet> wallets;

  GetWalletResponse({required this.wallets});

  factory GetWalletResponse.fromJson(List<dynamic> json) => GetWalletResponse(
        wallets: List<Wallet>.from(json.map((map) => Wallet.fromMap(map))),
      );

  List<Map<String, dynamic>> toJson() =>
      wallets.map((wallet) => wallet.toMap()).toList();
}
