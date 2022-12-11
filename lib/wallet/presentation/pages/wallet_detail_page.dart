import 'package:duitku/wallet/presentation/bloc/providers/wallet_provider.dart';
import 'package:duitku/wallet/presentation/bloc/states/delete_wallet_state.dart';
import 'package:duitku/wallet/presentation/pages/wallet_home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WalletDetailPage extends StatefulWidget {
  static const routeName = "/wallet/detail";

  const WalletDetailPage({super.key});

  @override
  State<WalletDetailPage> createState() => _WalletDetailPageState();
}

class _WalletDetailPageState extends State<WalletDetailPage> {
  final _currencyFormatter = NumberFormat.currency(
    symbol: "Rp",
    locale: "id-ID",
  );

  late int _walletId;

  WalletProvider? _walletProv;

  @override
  void initState() {
    _walletProv = context.read<WalletProvider>();
    _walletProv?.resetWalletDetail();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _walletId = ModalRoute.of(context)?.settings.arguments as int;
    _walletProv?.getWalletDetail(_walletId);
    super.didChangeDependencies();
  }

  Future<void> _deleteWallet() async {
    await _walletProv?.deleteWallet(_walletId);

    if (_walletProv?.deleteWalletState is DeleteWalletOkState) {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(WalletHomePage.routeName);
      }
    } else {
      final message = _walletProv?.deleteWalletState is DeleteWalletFailureState
          ? (_walletProv?.deleteWalletState as DeleteWalletFailureState).message
          : "Failed to delete wallet";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet Detail"),
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Delete Wallet",
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
                              "Are you sure you want to delete this wallet?",
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
                                  onPressed: _deleteWallet,
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
          await _walletProv?.getWalletDetail(_walletId);
        },
        child: FutureBuilder(
            future: _walletProv?.getWalletDetail(_walletId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_walletProv!.wallet == null) {
                return const Center(child: Text("Failed to get wallet"));
              }

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _walletProv!.wallet!.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _currencyFormatter.format(_walletProv!.wallet!.balance),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _walletProv!.wallet!.description,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
