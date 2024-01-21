import 'package:flutter/material.dart';
import 'package:portfolio/models/assets/asset.dart';
import 'package:portfolio/widgets/market/asset_prices_widget.dart';

class AssetWidget extends StatelessWidget {
  const AssetWidget({super.key, required this.asset});

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AssetPricesWidget(
                      asset: asset,
                    )));
      },
      child: Card(
        child: Column(
          children: [
            Text(
              asset.code,
            ),
            Text(
              asset.category.toString(),
            )
          ],
        ),
      ),
    );
  }
}
