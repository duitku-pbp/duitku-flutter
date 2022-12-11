import 'package:duitku/common/widgets/app_drawer.dart';
import 'package:duitku/wallet/presentation/bloc/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletDetailPage extends StatefulWidget {
  static const routeName = "/wallet/detail";

  const WalletDetailPage({super.key});

  @override
  State<WalletDetailPage> createState() => _WalletDetailPageState();
}

class _WalletDetailPageState extends State<WalletDetailPage> {
  late int _transactionId;

  WalletProvider? _walletProv;

  @override
  void initState() {
    _walletProv = context.read<WalletProvider>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _transactionId = ModalRoute.of(context)?.settings.arguments as int;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet Detail")),
      body: const Center(
        child: Text("Lol"),
      ),
    );
  }
}
