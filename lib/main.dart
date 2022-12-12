import 'package:duitku/auth/presentation/pages/login_page.dart';
import 'package:duitku/auth/presentation/bloc/providers/auth_provider.dart';
import 'package:duitku/common/pages/unknown_page.dart';
import 'package:duitku/common/widgets/app_drawer.dart';
import 'package:duitku/wallet/presentation/pages/create_transaction_page.dart';
import 'package:duitku/wallet/presentation/pages/create_wallet_page.dart';
import 'package:duitku/wallet/presentation/pages/transactions_page.dart';
import 'package:duitku/wallet/presentation/pages/wallet_home_page.dart';
import 'package:duitku/wallet/presentation/bloc/providers/wallet_provider.dart';
import 'package:duitku/investasiku/presentation/provider/investasiku_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  await di.init();

  runApp(const DuitkuApp());
}

class DuitkuApp extends StatelessWidget {
  const DuitkuApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProv = di.sl<AuthProvider>();
    final walletProv = di.sl<WalletProvider>();
    final portofolioProv = di.sl<PortofolioProvider>();

    authProv.init();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProv),
        ChangeNotifierProvider(create: (_) => walletProv),
        ChangeNotifierProvider(create: (_) => portofolioProv),
      ],
      child: MaterialApp(
        title: 'Duitku',
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: authProv.isAuthenticated
            ? MyHomePage.routeName
            : LoginPage.routeName,
        routes: {
          MyHomePage.routeName: (context) => const MyHomePage(),
          LoginPage.routeName: (context) => const LoginPage(),
          WalletHomePage.routeName: (context) => const WalletHomePage(),
          TransactionsPage.routeName: (context) => const TransactionsPage(),
          CreateTransactionPage.routeName: (context) =>
              const CreateTransactionPage(),
          CreateWalletPage.routeName: (context) => const CreateWalletPage(),
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => const UnknownPage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const routeName = "/home";

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Duitku")),
      drawer: const AppDrawer(),
    );
  }
}
