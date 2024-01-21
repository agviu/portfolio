import 'package:portfolio/models/assets/asset_list.dart';
import 'package:portfolio/models/assets/asset_date.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  test('Creates a list of assets from a valid JSON string', () async {
    try {
      var jsonFile = 'test/models/assets/valid_assets_list.json';
      String jsonContent = await File(jsonFile).readAsString();
      final AssetList assetList = AssetList.fromJson(jsonContent);
      if (assetList.length() != 7) {
        fail(
            "The number of assets in the JSON is 7, but ${assetList.length()} was read.");
      }
    } catch (e) {
      fail(
          'The creation of AssetList from a JSON failed with the exception: $e');
    }
  });

  test(
    'Sort assets by more value to less value',
    () async {
      var jsonFile = 'test/models/assets/valid_assets_list.json';
      String jsonContent = await File(jsonFile).readAsString();

      final AssetList assetList = AssetList.fromJson(jsonContent);

      // Get the list of assets sorted by the asset that had more value in a given date:
      assetList.sortByHigherValueOnDate(AssetDate("2023.48"));
      if (assetList.assets.first.code != 'SHIB') {
        fail("SHIB it the item with higher value in the asset list.");
      }
      if (assetList.assets.last.code != 'BNB') {
        fail("BNB is the item with lowest value in the asset list.");
      }
      assetList.sortByHigherValueOnDate(AssetDate("2023.47"));
      if (assetList.assets.first.code != 'DOT') {
        fail("DOT it the item with higher value in the asset list.");
      }
      if (assetList.assets.last.code != 'BNB') {
        fail("BNB is the item with lowest value in the asset list.");
      }

      // Get the list of assets sorted by the asset that had grown more in a given date:
      assetList.sortAssetsByGrowthSinceDate(AssetDate("2023.48"), 1);
      // assetList.assets.forEach((element) => print(element.code));

      if (assetList.assets.first.code != 'SHIB') {
        fail(
            "SHIB is the asset that did grow more in the last week from 2023.48");
      }

      // Get the list of assets sorted by the asset that had grown more in the last month:
      assetList.sortAssetsByGrowthSinceDate(AssetDate("2023.48"), 4);
      // assetList.assets.forEach((element) => print(element.code));
      if (assetList.assets[2].code != 'BNB') {
        fail("In the last 4 weeks, BNB was the third asset that growed more");
      }
      // Get the list of assets sorted by the asset that had grown more in the last months:
      assetList.sortAssetsByGrowthSinceDate(AssetDate("2023.48"), 12);
      // assetList.assets.forEach((element) => print(element.code));
      if (assetList.assets.last.code != 'BTC') {
        fail("In the last 12 weeks, BTC was the asset that growth the less");
      }
    },
  );
}
