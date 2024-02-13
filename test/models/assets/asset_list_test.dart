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
      if (assetList.length != 7) {
        fail(
            "The number of assets in the JSON is 7, but ${assetList.length} was read.");
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
      AssetList filtered;

      // Get the list of assets sorted by the asset that had more value in a given date:
      (filtered, _) = assetList.sortByHigherValueOnDate(AssetDate("2023.48"));
      if (filtered.assets.first.code != 'SHIB') {
        fail("SHIB it the item with higher value in the asset list.");
      }
      if (filtered.assets.last.code != 'BNB') {
        fail("BNB is the item with lowest value in the asset list.");
      }
      (filtered, _) = assetList.sortByHigherValueOnDate(AssetDate("2023.47"));
      if (filtered.assets.first.code != 'DOT') {
        fail("DOT it the item with higher value in the asset list.");
      }
      if (filtered.assets.last.code != 'BNB') {
        fail("BNB is the item with lowest value in the asset list.");
      }

      // Get the list of assets sorted by the asset that had grown more in a given date:
      (filtered, _) =
          assetList.sortAssetsByGrowthSinceDate(AssetDate("2023.48"), 1);
      // assetList.assets.forEach((element) => print(element.code));

      if (filtered.assets.first.code != 'SHIB') {
        fail(
            "SHIB is the asset that did grow more in the last week from 2023.48");
      }

      // Get the list of assets sorted by the asset that had grown more in the last month:
      (filtered, _) =
          assetList.sortAssetsByGrowthSinceDate(AssetDate("2023.48"), 4);
      // assetList.assets.forEach((element) => print(element.code));
      if (filtered.assets[2].code != 'BNB') {
        fail("In the last 4 weeks, BNB was the third asset that growed more");
      }
      // Get the list of assets sorted by the asset that had grown more in the last months:
      (filtered, _) =
          assetList.sortAssetsByGrowthSinceDate(AssetDate("2023.48"), 12);
      // assetList.assets.forEach((element) => print(element.code));
      if (filtered.assets.last.code != 'BTC') {
        fail("In the last 12 weeks, BTC was the asset that growth the less");
      }
    },
  );

  test(
    'Check sorting a list with a date that is out of the scope, will get an empty list',
    () async {
      var jsonFile = 'test/models/assets/valid_assets_list.json';
      String jsonContent = await File(jsonFile).readAsString();

      final AssetList assetList = AssetList.fromJson(jsonContent);
      AssetList filtered;
      AssetList discarded;

      (filtered, discarded) =
          assetList.sortByHigherValueOnDate(AssetDate("2024.33"));
      if (filtered.length != 0 || discarded.length != 7) {
        fail("With date 2024.33, all assets should be discarded.");
      }

      (filtered, discarded) =
          assetList.sortByHigherValueOnDate(AssetDate("2018.13"));
      if (filtered.length != 1 || discarded.length != 6) {
        fail("With date 2018.13, six assets should be discarded.");
      }
    },
  );

  test(
    'Loads a real JSON example, generated from the investrends app.',
    () async {
      var jsonFile = 'test/models/assets/real_example_assets_list.json';
      String jsonContent = await File(jsonFile).readAsString();

      final AssetList assetList = AssetList.fromJson(jsonContent);
      AssetList filtered;
      AssetList discarded;

      (filtered, discarded) =
          assetList.sortByHigherValueOnDate(AssetDate("2024.05"));
      if (filtered.length != 24 || discarded.length != 96) {
        fail("The number of discarded or filtered is not correct.");
      }
    },
  );
}
