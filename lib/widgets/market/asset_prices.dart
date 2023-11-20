import 'package:portfolio/models/asset.dart';
import 'package:flutter/material.dart';

class AssetPricesWidget extends StatelessWidget {
  AssetPricesWidget({super.key, required this.asset}) : prices = asset.prices;

  final Asset asset;

  final List<AssetPrice> prices;

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
                  Text(prices[index].timestamp.toString()),
                  Text(prices[index].value.toString()),
                ],
              ),
            );
          }),
    );
  }
}
