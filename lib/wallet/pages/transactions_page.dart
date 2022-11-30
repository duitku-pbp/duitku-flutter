import 'package:duitku/wallet/models/transaction.dart';
import 'package:duitku/wallet/models/transaction_group.dart';
import 'package:duitku/wallet/providers/wallet_provider.dart';
import 'package:duitku/wallet/widgets/wallet_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionsPage extends StatefulWidget {
  static const routeName = "/wallet/transaction";

  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final DateFormat dateFormatter = DateFormat("E, MMM dd, yyyy");

  WalletProvider? walletProv;

  Future<void>? _getTransactions;

  Future<void> _init() async {
    await walletProv?.getWallets();
    await walletProv?.getTransactions(_walletId);

    _getTransactions = walletProv?.getTransactions(_walletId);

    _setTotalBalance();
  }

  @override
  void initState() {
    walletProv = Provider.of<WalletProvider>(context, listen: false);
    _init();
    super.initState();
  }

  void _setTotalBalance() {
    double total = 0;
    final transactions = walletProv?.transactionGroups ?? [];

    for (TransactionGroup group in transactions) {
      for (Transaction trx in group.transactions) {
        total +=
            trx.type == TransactionType.outcome ? -1 * trx.amount : trx.amount;
      }
    }

    setState(() {
      _totalBalance = total;
    });
  }

  String _walletId = "all";
  double _totalBalance = 0;

  @override
  Widget build(BuildContext context) {
    return WalletScaffold(
      idx: 1,
      title: "Transactions",
      body: RefreshIndicator(
        child: FutureBuilder(
          future: _getTransactions,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 17),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 120),
                        ...walletProv!.transactionGroups.map(
                          (group) => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 40),
                              Text(
                                dateFormatter.format(
                                  group.date,
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ...group.transactions
                                  .asMap()
                                  .map(
                                    (i, trx) => MapEntry(
                                      i,
                                      Container(
                                        padding: const EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius: i == 0
                                              ? const BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                )
                                              : i ==
                                                      group.transactions
                                                              .length -
                                                          1
                                                  ? const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(5),
                                                      bottomRight:
                                                          Radius.circular(5),
                                                    )
                                                  : BorderRadius.circular(0),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            trx.description,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          subtitle: _walletId != "all"
                                              ? null
                                              : Text(
                                                  trx.wallet.name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                          trailing: Text(
                                            "Rp. ${trx.type == TransactionType.income ? "+" : "-"}${trx.amount}",
                                            style: TextStyle(
                                              color: trx.type ==
                                                      TransactionType.income
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .values
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              "Balance",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Rp. $_totalBalance",
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                          const SizedBox(height: 12),
                          InputDecorator(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                borderRadius: BorderRadius.circular(8),
                                value: _walletId,
                                items: [
                                  const DropdownMenuItem(
                                    value: "all",
                                    child: Text("All Wallets"),
                                  ),
                                  ...walletProv!.wallets
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.id.toString(),
                                          child: Text(e.name),
                                        ),
                                      )
                                      .toList()
                                ],
                                onChanged: (val) async {
                                  setState(() {
                                    _walletId = val!;
                                    _getTransactions =
                                        walletProv?.getTransactions(_walletId);
                                  });

                                  await _getTransactions;
                                  _setTotalBalance();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        onRefresh: () async {
          await walletProv?.getTransactions(_walletId);
          _setTotalBalance();
        },
      ),
    );
  }
}
