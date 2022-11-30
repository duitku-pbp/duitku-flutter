import 'package:duitku/wallet/models/wallet.dart';
import 'package:intl/intl.dart';

enum TransactionType {
  income("INCOME"),
  outcome("OUTCOME");

  final String text;
  const TransactionType(this.text);

  factory TransactionType.fromString(String text) {
    if (text == "INCOME") {
      return TransactionType.income;
    } else {
      return TransactionType.outcome;
    }
  }

  @override
  String toString() => text;
}

class Transaction {
  int id;
  int actorId;
  Wallet wallet;
  double amount;
  DateTime doneOn;
  TransactionType type;
  String description;

  final _dateFormatter = DateFormat("yyyy-MM-dd");

  Transaction({
    required this.id,
    required this.actorId,
    required this.wallet,
    required this.amount,
    required this.doneOn,
    required this.type,
    required this.description,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) => Transaction(
        id: map["id"],
        actorId: map["actor"],
        wallet: Wallet.fromMap(map["wallet"]),
        amount: double.tryParse(map["amount"]) ?? 0,
        doneOn: DateTime.tryParse(map["done_on"]) ?? DateTime(1970, 1, 1),
        type: TransactionType.fromString(map["type"]),
        description: map["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "actor": actorId,
        "wallet": wallet.toMap(),
        "amount": amount,
        "done_on": _dateFormatter.format(doneOn),
        "type": type.toString(),
        "description": description,
      };
}
