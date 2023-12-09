import 'package:portfolio/models/assets/asset.dart';
import 'dart:convert';

class AssetList {
  AssetList(this.assets);

  factory AssetList.fromJson(String jsonContent) {
    var content = jsonDecode(jsonContent);

    List<Asset> assets =
        (content as List).map((assetMap) => Asset.fromJson(assetMap)).toList();
    return AssetList(assets);
  }

  List<Asset> assets;

  int length() {
    return assets.length;
  }
}
