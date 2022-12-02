import 'package:duitku/wallet/messages/create_wallet_request.dart';
import 'package:duitku/wallet/pages/wallet_home_page.dart';
import 'package:duitku/wallet/providers/wallet_provider.dart';
import 'package:duitku/wallet/states/create_wallet_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateWalletPage extends StatefulWidget {
  static const routeName = "/wallet/create";

  const CreateWalletPage({super.key});

  @override
  State<CreateWalletPage> createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {
  final _createWalletFormKey = GlobalKey<FormState>();

  WalletProvider? _walletProv;

  String? _name;
  double? _initialBalance;
  String? _description;

  @override
  void initState() {
    _walletProv = context.read<WalletProvider>();
    super.initState();
  }

  Future<void> _createWallet() async {
    if (_createWalletFormKey.currentState!.validate()) {
      final body = CreateWalletRequest(
        name: _name!,
        initialBalance: _initialBalance!,
        description: _description ?? "",
      );

      await _walletProv?.createWallet(body: body);

      if (_walletProv?.createWalletState is CreateWalletOkState) {
        _walletProv?.resetStates();

        if (mounted) {
          Navigator.of(context).pushReplacementNamed(WalletHomePage.routeName);
        }
      } else {
        final message =
            _walletProv?.createWalletState is CreateWalletFailureState
                ? (_walletProv?.createWalletState as CreateWalletFailureState)
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
    return Scaffold(
      appBar: AppBar(title: const Text("Add Wallet")),
      body: Form(
        key: _createWalletFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Create New Wallet",
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Name",
                                  hintText: "ex: Emergency Funds",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                                onChanged: (String? val) {
                                  setState(() {
                                    _name = val?.trim();
                                  });
                                },
                                onSaved: (String? val) {
                                  setState(() {
                                    _name = val?.trim();
                                  });
                                },
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return "Please enter a name for this wallet";
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
                                  labelText: "Initial Balance (Rp.)",
                                  hintText: "ex: 10000",
                                  contentPadding: const EdgeInsets.all(10),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                onChanged: (String? val) {
                                  setState(() {
                                    _initialBalance =
                                        double.tryParse(val ?? "");
                                  });
                                },
                                onSaved: (String? val) {
                                  setState(() {
                                    _initialBalance =
                                        double.tryParse(val ?? "");
                                  });
                                },
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please enter an initial balance";
                                  } else if (double.tryParse(val) == null) {
                                    return "Balance must be numeric";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 25),
                              TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 6,
                                decoration: InputDecoration(
                                  labelText: "Description",
                                  hintText: "ex: FOR EMERGENCIES ONLY",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                                onChanged: (String? val) {
                                  setState(() {
                                    _description = val?.trim();
                                  });
                                },
                                onSaved: (String? val) {
                                  setState(() {
                                    _description = val?.trim();
                                  });
                                },
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: _createWallet,
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
