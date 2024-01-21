import 'package:flutter/material.dart';
import 'package:portfolio/models/assets/asset.dart';
import 'package:portfolio/models/assets/asset_list.dart';
import 'package:portfolio/widgets/market/asset_widget.dart';

class AssetListWidget extends StatefulWidget {
  const AssetListWidget({super.key, required this.assetList});

  final AssetList assetList;

  @override
  State<AssetListWidget> createState() => _AssetListWidgetState();
}

class _AssetListWidgetState extends State<AssetListWidget> {
  late List<Asset> assets;

  @override
  void initState() {
    super.initState();
    assets = widget.assetList.assets;
    // Optionally, you can sort assets on initialization
    // For example: sort by higher value on a specific date
    // assets.sortByHigherValueOnDate(someDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market List'),
        actions: [
          // You can add buttons or actions to sort the list based on different criteria
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _sortAssets, // Implement this method to sort assets
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: assets.length,
        itemBuilder: (BuildContext context, int index) {
          return AssetWidget(asset: assets[index]);
        },
      ),
    );
  }

  void _sortAssets() {
    // Implement the sorting logic based on your needs
    // For example, you might want to show a dialog to choose the sorting criteria
    // setState(() {
    //   assets.sortByHigherValueOnDate(someDate);
    // });
  }
}
