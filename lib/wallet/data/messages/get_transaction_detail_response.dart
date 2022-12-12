import 'package:duitku/wallet/data/models/transaction.dart';

class GetTransactionDetailResponse {
  final Transaction transaction;

  const GetTransactionDetailResponse({required this.transaction});

  factory GetTransactionDetailResponse.fromJson(Map<String, dynamic> json) =>
      GetTransactionDetailResponse(transaction: Transaction.fromMap(json));

  Map<String, dynamic> toJson() => transaction.toMap();
}
