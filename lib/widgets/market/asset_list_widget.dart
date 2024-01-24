import 'package:flutter/material.dart';
import 'package:portfolio/models/assets/asset_date.dart';
import 'package:portfolio/models/assets/asset_list.dart';
import 'package:portfolio/widgets/market/asset_widget.dart';

class AssetListWidget extends StatefulWidget {
  const AssetListWidget(
      {super.key, required this.assetList, required this.initialDate});

  final AssetList assetList;

  final AssetDate initialDate;

  @override
  State<AssetListWidget> createState() => _AssetListWidgetState();
}

class _AssetListWidgetState extends State<AssetListWidget> {
  late AssetList assetList;
  late AssetDate initialDate;

  @override
  void initState() {
    super.initState();
    initialDate = widget.initialDate;
    assetList = widget.assetList.sortByHigherValueOnDate(initialDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              // Handle the action based on the selected value
              if (value == 'sortHigherGrowthLastWeek') {
                _sortAssetsByGrowthSinceDate(1);
              } else if (value == 'sortHigherGrowthLastMonth') {
                _sortAssetsByGrowthSinceDate(4);
              } else if (value == 'sortHigherGrowthLastQuarter') {
                _sortAssetsByGrowthSinceDate(12);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'sortHigherGrowthLastWeek',
                child: Text('Higher Growth Last Week'),
              ),
              const PopupMenuItem<String>(
                value: 'sortHigherGrowthLastMonth',
                child: Text('Higher Growth Last Month'),
              ),
              const PopupMenuItem<String>(
                value: 'sortHigherGrowthLastQuarter',
                child: Text('Higher Growth Last Quarter'),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: assetList.length,
        itemBuilder: (BuildContext context, int index) {
          return AssetWidget(asset: assetList.assets[index]);
        },
      ),
    );
  }

  void _sortAssetsByGrowthSinceDate(int dateTimes) {
    setState(
      () {
        assetList.sortAssetsByGrowthSinceDate(initialDate, dateTimes);
      },
    );
  }
}
