import 'package:portfolio/models/assets/asset.dart';
import 'package:portfolio/models/assets/asset_date.dart';
import 'package:portfolio/models/assets/asset_price.dart';
import 'package:flutter/material.dart';

class AssetPricesWidget extends StatelessWidget {
  AssetPricesWidget({super.key, required this.asset}) : prices = asset.prices;

  final Asset asset;

  final Map<AssetDate, AssetPrice> prices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(asset.code)),
      body: ListView.builder(
        itemCount: prices.length,
        itemBuilder: (BuildContext context, int index) {
          AssetDate date = prices.keys.elementAt(index);
          AssetPrice price = prices.values.elementAt(index);

          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(date.toString()), // Display the date
                Text(_formatPrice(price)), // Display the price
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatPrice(AssetPrice price) {
    // Check if the price is real or estimated and format accordingly
    if (price.isReal()) {
      return 'Real: \$${price.getRealValue()}';
    } else if (price.isEstimated()) {
      return 'Estimated: \$${price.estimatedValue}';
    } else {
      return 'Unknown';
    }
  }
}
