import 'package:flutter/material.dart';
import 'package:portfolio/models/assets/asset.dart';
import 'package:portfolio/models/assets/asset_list.dart';
import 'package:portfolio/widgets/market/asset_widget.dart';

class MarketList extends StatefulWidget {
  const MarketList({super.key});

  @override
  State<StatefulWidget> createState() {
    List<Asset> assets = [];
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
        return AssetWidget(asset: assets[index]);
      },
    );
  }
}
