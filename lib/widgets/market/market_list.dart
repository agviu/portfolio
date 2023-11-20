import 'package:flutter/material.dart';
import 'package:portfolio/models/asset.dart';
import 'package:portfolio/widgets/market/asset_item.dart';

class MarketList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    List<Asset> assets = [
      Asset(code: 'BTC', prices: [
        AssetPrice(timestamp: DateTime.now(), value: 10),
        AssetPrice(timestamp: DateTime.now(), value: 10),
        AssetPrice(timestamp: DateTime.now(), value: 10),
        AssetPrice(timestamp: DateTime.now(), value: 10),
        AssetPrice(timestamp: DateTime.now(), value: 10),
        AssetPrice(timestamp: DateTime.now(), value: 10),
      ]),
      Asset(code: 'ETH', prices: [
        AssetPrice(timestamp: DateTime.now(), value: 20),
        AssetPrice(timestamp: DateTime.now(), value: 20),
        AssetPrice(timestamp: DateTime.now(), value: 20),
        AssetPrice(timestamp: DateTime.now(), value: 20),
        AssetPrice(timestamp: DateTime.now(), value: 20),
        AssetPrice(timestamp: DateTime.now(), value: 20),
      ]),
      Asset(code: 'CRYPTO1', prices: [
        AssetPrice(timestamp: DateTime.now(), value: 30),
        AssetPrice(timestamp: DateTime.now(), value: 30),
        AssetPrice(timestamp: DateTime.now(), value: 30),
        AssetPrice(timestamp: DateTime.now(), value: 30),
        AssetPrice(timestamp: DateTime.now(), value: 30),
        AssetPrice(timestamp: DateTime.now(), value: 30),
      ]),
      Asset(code: 'CRYPTO2', prices: [
        AssetPrice(timestamp: DateTime.now(), value: 40),
        AssetPrice(timestamp: DateTime.now(), value: 40),
        AssetPrice(timestamp: DateTime.now(), value: 40),
        AssetPrice(timestamp: DateTime.now(), value: 40),
        AssetPrice(timestamp: DateTime.now(), value: 40),
        AssetPrice(timestamp: DateTime.now(), value: 40),
      ]),
      Asset(code: 'CRYPTO3', prices: [
        AssetPrice(timestamp: DateTime.now(), value: 50),
        AssetPrice(timestamp: DateTime.now(), value: 50),
        AssetPrice(timestamp: DateTime.now(), value: 50),
        AssetPrice(timestamp: DateTime.now(), value: 50),
        AssetPrice(timestamp: DateTime.now(), value: 50),
        AssetPrice(timestamp: DateTime.now(), value: 50),
      ]),
    ];

    // TODO: implement createState
    return _MarketListState(assets);
  }
}

class _MarketListState extends State<MarketList> {
  _MarketListState(this.assets);

  final List<Asset> assets;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: assets.length,
      itemBuilder: (BuildContext context, int index) {
        return AssetItemWidget(asset: assets[index]);
      },
    );
  }
}
