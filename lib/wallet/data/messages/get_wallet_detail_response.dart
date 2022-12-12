import 'package:duitku/wallet/data/models/wallet.dart';

class GetWalletDetailResponse {
  final Wallet wallet;

  GetWalletDetailResponse({required this.wallet});

  factory GetWalletDetailResponse.fromJson(Map<String, dynamic> json) =>
      GetWalletDetailResponse(
        wallet: Wallet.fromMap(json),
      );

  Map<String, dynamic> toJson() => wallet.toMap();
}
