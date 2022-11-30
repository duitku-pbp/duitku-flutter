import 'package:duitku/wallet/widgets/wallet_scaffold.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  static const routeName = "/wallet/transaction";

  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return const WalletScaffold(
      idx: 1,
      title: "Transactions",
      body: Center(
        child: Text("TODO: Implement transactions page"),
      ),
    );
  }
}
