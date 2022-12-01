import 'package:duitku/wallet/messages/create_transaction_request.dart';
import 'package:duitku/wallet/models/transaction.dart';
import 'package:duitku/wallet/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTransactionPage extends StatefulWidget {
  static const routeName = "/wallet/transaction/create";

  const CreateTransactionPage({super.key});

  @override
  State<CreateTransactionPage> createState() => _CreateTransactionPageState();
}

class _CreateTransactionPageState extends State<CreateTransactionPage> {
  WalletProvider? walletProv;

  @override
  void initState() {
    walletProv = Provider.of<WalletProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Transaction")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await walletProv?.createTransaction(
              body: CreateTransactionRequest(
                walletId: 1,
                type: TransactionType.income,
                amount: 1000,
                doneOn: DateTime.now(),
                description: "",
              ),
            );

            walletProv?.resetStates();
          },
          child: const Text("Create"),
        ),
      ),
    );
  }
}
