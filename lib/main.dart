import 'package:duitku/auth/pages/login_page.dart';
import 'package:duitku/auth/providers/auth_provider.dart';
import 'package:duitku/common/pages/unknown_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(DuitkuApp());
}

class DuitkuApp extends StatelessWidget {
  DuitkuApp({super.key});

  final client = IOClient();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(client: client),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Duitku',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: auth.isAuthenticated ? const MyHomePage() : const LoginPage(),
          routes: {
            MyHomePage.routeName: (context) => const MyHomePage(),
            LoginPage.routeName: (context) => const LoginPage(),
          },
          onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => const UnknownPage(),
          ),
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
    );
  }
}
