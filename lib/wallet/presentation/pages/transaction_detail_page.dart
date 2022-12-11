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
  final _currencyFormatter = NumberFormat.currency(
    symbol: "Rp",
    locale: "id-ID",
  );

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
      appBar: AppBar(title: const Text("Transaction Detail")),
    );
  }
}
