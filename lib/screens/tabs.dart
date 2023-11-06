import 'package:flutter/material.dart';
import 'package:portfolio/widgets/investments.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: const Text("Investrends Portfolio"),
          actions: [
            // IconButton(
            //   onPressed: _openAddInvestmentOverlay,
            //   icon: const Icon(Icons.add),
            // ),
          ],
        ),
        body: Investments());
  }
}
