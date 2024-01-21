import 'package:flutter/material.dart';
import 'package:portfolio/widgets/market/asset_list_widget.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text('Market'),
        ),
        body: const Column(
          children: [
            Expanded(
              child: MarketList(),
            ),
          ],
        ));
  }
}
