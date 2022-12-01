import 'package:duitku/common/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Duitku")),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text("Page not found"),
      ),
    );
  }
}
