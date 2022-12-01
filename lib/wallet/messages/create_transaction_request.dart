import 'package:duitku/wallet/models/transaction.dart';
import 'package:intl/intl.dart';

class CreateTransactionRequest {
  int walletId;
  double amount;
  TransactionType type;
  DateTime doneOn;
  String description;

  final _dateFormatter = DateFormat("yyyy-MM-dd");

  CreateTransactionRequest({
    required this.walletId,
    required this.amount,
    required this.type,
    required this.doneOn,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        "wallet": walletId,
        "amount": amount,
        "type": type.toString(),
        "done-on": _dateFormatter.format(doneOn),
        "description": description,
      };
}
