import 'package:duitku/wallet/data/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionGroup {
  DateTime date;
  List<Transaction> transactions;

  final _dateFormatter = DateFormat("yyyy-MM-dd");

  TransactionGroup({
    required this.date,
    required this.transactions,
  });

  factory TransactionGroup.fromMap(Map<String, dynamic> map) =>
      TransactionGroup(
        date: DateTime.tryParse(map["date"]) ?? DateTime(1970, 1, 1),
        transactions: List<Transaction>.from(
          map["transactions"].map((trx) => Transaction.fromMap(trx)),
        ),
      );

  Map<String, dynamic> toMap() => {
        "date": _dateFormatter.format(date),
        "transactions": transactions.map((trx) => trx.toMap()).toList(),
      };
}
