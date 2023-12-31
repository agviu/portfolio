import 'package:portfolio/models/assets/asset.dart';
import 'package:flutter/material.dart';

class AssetPricesWidget extends StatelessWidget {
  AssetPricesWidget({super.key, required this.asset}) : prices = asset.prices;

  final Asset asset;

  final Map<String, double> prices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(asset.code)),
      body: ListView.builder(
          itemCount: prices.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Row(
                children: [
                  // Text(prices[index]!.time),
                  // Text(prices[index]!.value.toString()),
                ],
              ),
            );
          }),
    );
  }
}
