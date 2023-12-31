import 'package:flutter/material.dart';
import 'package:portfolio/screens/market_screen.dart';
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
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('My portfolio'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Market'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MarketScreen()));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("Investrends Portfolio"),
          actions: const [
            // IconButton(
            //   onPressed: _openAddInvestmentOverlay,
            //   icon: const Icon(Icons.add),
            // ),
          ],
        ),
        body: const Investments());
  }
}
