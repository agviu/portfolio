import 'package:portfolio/models/category.dart';
import 'package:portfolio/models/time_mode.dart';
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
    Map<String, double> pricesMap = {};

    final TimeMode mode;

    if (jsonContent.containsKey('mode') && jsonContent['mode'] != null) {
      mode = stringToTimeMode(jsonContent['mode']);
    } else {
      // Default value.
      mode = TimeMode.yearWeek;
    }

    for (var pricesData in priceList) {
      // Add to the map
      pricesMap[pricesData[timeModeToString(mode)]] =
          pricesData["value"].toDouble();
    }

    return Asset(
      code: jsonContent['code'],
      prices: pricesMap,
      category: stringToCategory(jsonContent['category']),
      mode: mode,
    );
  }

  final String code;

  final Map<String, double> prices;

  final Category category;

  final TimeMode mode;

  double? price(dynamic from, [TimeMode mode = TimeMode.yearWeek]) {
    return prices[from];
  }
}
