import 'package:portfolio/models/category.dart';
import 'package:portfolio/models/assets/asset_price.dart';

class Asset {
  const Asset({
    required this.code,
    required this.prices,
    this.category = Category.crypto,
  });

  factory Asset.fromJson(Map<String, dynamic> jsonContent) {
    var priceList = jsonContent['prices'] as List;
    List<AssetPrice> prices = priceList
        .map((pricesData) => AssetPrice(
              timestamp: DateTime.parse(pricesData["timestamp"]),
              value: pricesData["value"].toDouble(),
            ))
        .toList();

    return Asset(
      code: jsonContent['code'],
      prices: prices,
      category: stringToCategory(jsonContent['category']),
    );
  }

  final String code;

  final List<AssetPrice> prices;

  final Category category;
}
