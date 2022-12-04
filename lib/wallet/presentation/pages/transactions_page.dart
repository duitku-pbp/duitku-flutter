import 'package:duitku/wallet/data/models/transaction.dart';
import 'package:duitku/wallet/data/models/transaction_group.dart';
import 'package:duitku/wallet/presentation/providers/wallet_provider.dart';
import 'package:duitku/wallet/presentation/widgets/wallet_scaffold.dart';
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
  final DateFormat _dateFormatter = DateFormat("E, MMM dd, yyyy");

  WalletProvider? _walletProv;

  @override
  void initState() {
    _walletProv = context.read<WalletProvider>();

    _walletProv?.getWallets();
    _walletProv?.getTransactions(_walletId);

    _setTotalBalance();
    super.initState();
  }

  void _setTotalBalance() {
    double total = 0;
    final transactions = _walletProv?.transactionGroups ?? [];

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
          future: _walletProv?.getTransactions(_walletId),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 17),
              child: Stack(
                children: [
                  _walletProv!.wallets.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(height: 120),
                              Text("You haven't made any transactions yet"),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 120),
                              ..._walletProv!.transactionGroups.map(
                                (group) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 40),
                                    Text(
                                      _dateFormatter.format(
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
                                                        topLeft:
                                                            Radius.circular(5),
                                                        topRight:
                                                            Radius.circular(5),
                                                      )
                                                    : i ==
                                                            group.transactions
                                                                    .length -
                                                                1
                                                        ? const BorderRadius
                                                            .only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                          )
                                                        : BorderRadius.circular(
                                                            0),
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  trx.description,
                                                  style: const TextStyle(
                                                      fontSize: 18),
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
                                                            TransactionType
                                                                .income
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
                    top: _walletProv!.transactionGroups.isEmpty ? null : 0,
                    left: _walletProv!.transactionGroups.isEmpty ? null : 0,
                    right: _walletProv!.transactionGroups.isEmpty ? null : 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                                  ..._walletProv!.wallets
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
                                  });

                                  await _walletProv?.getTransactions(_walletId);
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
          await _walletProv?.getTransactions(_walletId);
          _setTotalBalance();
        },
      ),
    );
  }
}
