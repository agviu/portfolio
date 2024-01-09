import 'package:portfolio/models/category.dart';
import 'package:portfolio/models/time_mode.dart';
import 'package:portfolio/models/assets/asset_price.dart';
import 'package:portfolio/utils/dates.dart';

class Asset {
  const Asset({
    required this.code,
    required this.prices,
    this.category = Category.crypto,
    this.mode = TimeMode.yearWeek,
  });

  factory Asset.fromJson(Map<String, dynamic> jsonContent) {
    var priceList = jsonContent['prices'] as List;
    Map<String, AssetPrice> pricesMap = {};

    final TimeMode mode;

    if (jsonContent.containsKey('mode') && jsonContent['mode'] != null) {
      mode = stringToTimeMode(jsonContent['mode']);
    } else {
      // Default value.
      mode = TimeMode.yearWeek;
    }

    for (var pricesData in priceList) {
      // Add to the map
      // pricesMap[pricesData[timeModeToString(mode)]] =
      //     pricesData["value"].toDouble();
      pricesMap[pricesData[timeModeToString(mode)]] =
          AssetPrice(pricesData["value"].toDouble(), mode: mode);
    }

    return Asset(
      code: jsonContent['code'],
      prices: pricesMap,
      category: stringToCategory(jsonContent['category']),
      mode: mode,
    );
  }

  final String code;

  final Map<String, AssetPrice> prices;

  final Category category;

  final TimeMode mode;

  AssetPrice price(String date, [TimeMode mode = TimeMode.yearWeek]) {
    return prices[date] ?? AssetPrice.estimated(estimatePriceValue(date));
  }

  double estimatePriceValue(date) {
    // Get the next value in the future, if it exists.
    throw Error();
  }

  /// Gets the highest (recent in time) date that contains real price information.
  String getHighestDateWithRealValue() {
    if (prices.isEmpty) {
      throw StateError("The prices map is empty.");
    }

    String highestKey = prices.keys.first;
    for (String key in prices.keys) {
      if (compareDates(key, highestKey) > 0) {
        highestKey = key;
      }
    }

    return highestKey;
  }

  /// Gets the lowest (oldest in time) date that contains real price information.
  String getLowestDateWithRealValue() {
    if (prices.isEmpty) {
      throw StateError("The prices map is empty.");
    }

    String lowestKey = prices.keys.first;
    for (String key in prices.keys) {
      if (compareDates(key, lowestKey) < 0) {
        lowestKey = key;
      }
    }

    return lowestKey;
  }
}
