import 'package:portfolio/models/assets/asset_list.dart';
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

  test('Sort assets by more value to less value', () async {
    var jsonFile = 'test/models/assets/valid_assets_list.json';
    String jsonContent = await File(jsonFile).readAsString();

    final AssetList assetList = AssetList.fromJson(jsonContent);

    // Get the list of assets sorted by the asset that had more value in a given week:
    assetList.sortByHigherValueFromDate("2023.48");
    if (assetList.assets.first.code != 'SHIB') {
      fail("SHIB it the item with higher value in the asset list.");
    }
    if (assetList.assets.last.code != 'BNB') {
      fail("BNB is the item with lowest value in the asset list.");
    }
    assetList.sortByHigherValueFromDate("2023.47");
    if (assetList.assets.first.code != 'DOT') {
      fail("DOT it the item with higher value in the asset list.");
    }
    if (assetList.assets.last.code != 'BNB') {
      fail("BNB is the item with lowest value in the asset list.");
    }

    // Get the list of assets sorted by the asset that had grown more in the last week:

    // Get the list of assets sorted by the asset that had grown more in the last month:

    // Get the list of assets sorted by the asset that had grown more in the last months:
  });
}
