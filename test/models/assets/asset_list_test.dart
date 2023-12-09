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
}
