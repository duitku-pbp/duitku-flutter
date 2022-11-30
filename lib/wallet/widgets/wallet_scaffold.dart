import 'package:duitku/common/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class WalletScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final int idx;

  const WalletScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.idx,
  });

  @override
  State<WalletScaffold> createState() => _WalletScaffoldState();
}

class _WalletScaffoldState extends State<WalletScaffold> {
  late int _curIdx;

  @override
  void initState() {
    _curIdx = widget.idx;
    super.initState();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(widget.title),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _curIdx,
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: (newIdx) {
        setState(() {
          _curIdx = newIdx;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.atm), label: "Transactions"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: const AppDrawer(),
      body: widget.body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }
}
