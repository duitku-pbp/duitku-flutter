import 'package:duitku/wallet/data/models/transaction.dart';
import 'package:duitku/wallet/presentation/bloc/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionDetailPage extends StatefulWidget {
  static const routeName = "/wallet/transaction/detail";

  const TransactionDetailPage({super.key});

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  final _dateFormatter = DateFormat("EEEE, MMM dd, yyyy");
  final _currencyFormatter = NumberFormat.currency(
    symbol: "Rp",
    locale: "id-ID",
  );

  late int _transactionId;

  WalletProvider? _walletProv;

  @override
  void initState() {
    _walletProv = context.read<WalletProvider>();
    _walletProv?.resetTransactionDetail();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _transactionId = ModalRoute.of(context)?.settings.arguments as int;
    _walletProv?.getTransactionDetail(_transactionId);
    super.didChangeDependencies();
  }

  Future<void> _deleteTransaction() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Detail"),
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Delete Transaction",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  titlePadding: const EdgeInsets.symmetric(vertical: 18),
                  contentPadding: const EdgeInsets.all(12),
                  content: SizedBox(
                    height: 105,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              "Are you sure you want to delete this transaction?",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("No"),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _deleteTransaction,
                                  child: const Text("Yes"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _walletProv?.getTransactionDetail(_transactionId);
        },
        child: FutureBuilder(
          future: _walletProv?.getTransactionDetail(_transactionId),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_walletProv!.transaction == null) {
              return const Center(child: Text("Failed to get transaction"));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _walletProv!.transaction!.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      _currencyFormatter
                          .format(_walletProv!.transaction!.amount),
                      style: TextStyle(
                        fontSize: 24,
                        color: _walletProv!.transaction!.type ==
                                TransactionType.income
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ListTile(
                      minLeadingWidth: 0,
                      contentPadding: const EdgeInsets.only(left: 0),
                      leading: const Icon(Icons.calendar_today),
                      title: Text(
                        _dateFormatter.format(_walletProv!.transaction!.doneOn),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 0),
                      minLeadingWidth: 0,
                      leading: const Icon(Icons.wallet),
                      title: Text(
                        _walletProv!.transaction!.wallet.name,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
