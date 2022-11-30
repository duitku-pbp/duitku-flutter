import 'package:duitku/wallet/models/transaction_group.dart';

class GetTransactionsResponse {
  final List<TransactionGroup> transactionGroups;

  GetTransactionsResponse({required this.transactionGroups});

  factory GetTransactionsResponse.fromJson(List<dynamic> json) =>
      GetTransactionsResponse(
        transactionGroups: List<TransactionGroup>.from(
          json.map((group) => TransactionGroup.fromMap(group)),
        ),
      );

  List<Map<String, dynamic>> toJson() =>
      transactionGroups.map((group) => group.toMap()).toList();
}
