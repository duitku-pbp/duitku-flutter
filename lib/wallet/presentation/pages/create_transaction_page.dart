import 'package:duitku/wallet/data/messages/create_transaction_request.dart';
import 'package:duitku/wallet/data/models/transaction.dart';
import 'package:duitku/wallet/presentation/pages/transactions_page.dart';
import 'package:duitku/wallet/presentation/bloc/providers/wallet_provider.dart';
import 'package:duitku/wallet/presentation/bloc/states/create_transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateTransactionPage extends StatefulWidget {
  static const routeName = "/wallet/transaction/create";

  const CreateTransactionPage({super.key});

  @override
  State<CreateTransactionPage> createState() => _CreateTransactionPageState();
}

class _CreateTransactionPageState extends State<CreateTransactionPage> {
  final GlobalKey<FormState> _createTransactionFormKey = GlobalKey();
  final now = DateTime.now();
  final firstDate = DateTime(1970, 1, 1);

  final _dateFormatter = DateFormat("yyyy-MM-dd");
  final TextEditingController _doneOnController = TextEditingController();

  WalletProvider? walletProv;

  int? _walletId;
  double? _amount;
  TransactionType? _type;
  DateTime? _doneOn;
  String? _description;

  @override
  void initState() {
    walletProv = Provider.of<WalletProvider>(context, listen: false);
    walletProv?.getWallets();
    super.initState();
  }

  Future<void> _createTransaction() async {
    if (_createTransactionFormKey.currentState!.validate()) {
      final body = CreateTransactionRequest(
        walletId: _walletId!,
        amount: _amount!,
        type: _type!,
        doneOn: _doneOn!,
        description: _description!,
      );

      await walletProv?.createTransaction(body: body);

      if (walletProv?.createTransactionState is CreateTransactionOkState) {
        walletProv?.resetStates();

        if (mounted) {
          Navigator.of(context)
              .pushReplacementNamed(TransactionsPage.routeName);
        }
      } else {
        final message =
            walletProv?.createTransactionState is CreateTransactionFailureState
                ? (walletProv?.createTransactionState
                        as CreateTransactionFailureState)
                    .message
                : "An error occured";
        final snackBar = SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
        );

        if (mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lastDate =
        DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));

    return Scaffold(
      appBar: AppBar(title: const Text("Add Transaction")),
      body: Form(
        key: _createTransactionFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Create New Transaction",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Description",
                                  hintText: "ex: Lunch",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                                onChanged: (String? val) {
                                  setState(() {
                                    _description = val;
                                  });
                                },
                                onSaved: (String? val) {
                                  setState(() {
                                    _description = val;
                                  });
                                },
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please enter a description";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 25),
                              TextFormField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: true,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Amount (Rp.)",
                                  hintText: "ex: 1000",
                                  contentPadding: const EdgeInsets.all(10),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                onChanged: (String? val) {
                                  setState(() {
                                    _amount = double.tryParse(val ?? "");
                                  });
                                },
                                onSaved: (String? val) {
                                  setState(() {
                                    _amount = double.tryParse(val ?? "");
                                  });
                                },
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please enter an amount for the transaction";
                                  } else if (double.tryParse(val) == null) {
                                    return "Amount must be numeric";
                                  } else if (double.parse(val) <= 0) {
                                    return "Amount must be a positive number";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 25),
                              TextFormField(
                                readOnly: true,
                                controller: _doneOnController,
                                keyboardType: TextInputType.datetime,
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: now,
                                    firstDate: firstDate,
                                    lastDate: lastDate,
                                    keyboardType: TextInputType.datetime,
                                  );

                                  if (selectedDate != null) {
                                    setState(() {
                                      _doneOnController.text =
                                          _dateFormatter.format(selectedDate);
                                      _doneOn = selectedDate;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: "Done on",
                                  hintText: "ex: 1970-01-01",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please enter a date for the transaction";
                                  } else if (DateTime.tryParse(val) == null) {
                                    return "Date is not valid";
                                  } else if (DateTime.parse(val)
                                          .isAtSameMomentAs(lastDate) ||
                                      DateTime.parse(val).isAfter(lastDate)) {
                                    return "Can only enter dates up until the current month";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 25),
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    labelText: "Type",
                                    hintText: "Select a transaction type",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                  ),
                                  value: _type,
                                  items: [
                                    DropdownMenuItem(
                                      value: TransactionType.income,
                                      child: Text(TransactionType.income.text),
                                    ),
                                    DropdownMenuItem(
                                      value: TransactionType.outcome,
                                      child: Text(TransactionType.outcome.text),
                                    )
                                  ],
                                  onChanged: (val) {
                                    setState(() {
                                      _type = val;
                                    });
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      _type = val;
                                    });
                                  },
                                  validator: (val) {
                                    if (val == null) {
                                      return "Please select a transaction type";
                                    } else if (val != TransactionType.income &&
                                        val != TransactionType.outcome) {
                                      return "Not a valid transaction type";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 25),
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    labelText: "Wallet",
                                    hintText: "Select a wallet",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                  ),
                                  value: _walletId,
                                  items: walletProv != null &&
                                          walletProv!.wallets.isNotEmpty
                                      ? walletProv!.wallets
                                          .map((wallet) => DropdownMenuItem(
                                                value: wallet.id,
                                                child: Text(
                                                  "${wallet.name} (${wallet.balance})",
                                                ),
                                              ))
                                          .toList()
                                      : const [
                                          DropdownMenuItem(
                                            value: -1,
                                            child: Text("Select a wallet"),
                                          )
                                        ],
                                  onChanged: (val) {
                                    setState(() {
                                      _walletId = val;
                                    });
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      _walletId = val;
                                    });
                                  },
                                  validator: (val) {
                                    if (val == null) {
                                      return "Please select a wallet";
                                    } else if (val == -1) {
                                      return "No wallets found";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: _createTransaction,
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                      ),
                                      child: const Text(
                                        "Create",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
