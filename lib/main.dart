import 'package:duitku/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';

void main() {
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
          home: const MyHomePage(),
          routes: {
            MyHomePage.routeName: (context) => const MyHomePage(),
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const routeName = "/";

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Duitku")),
    );
  }
}
