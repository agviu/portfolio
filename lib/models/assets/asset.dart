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
    if (prices[date] == null) {
      prices[date] = AssetPrice.estimated(estimatePriceValue(date));
    }

    return prices[date]!;
  }

  /// Estimates the price value for a given date based on historical data.
  ///
  /// This function estimates the price value by calculating an average value
  /// between the closest known values before and after the provided date.
  /// It uses the `getHighestDateWithRealValue` and `getLowestDateWithRealValue`
  /// functions to determine the range of dates for which data is available.
  ///
  /// The function iterates through the dates, moving both forwards and backwards
  /// from the given date, until it finds the closest real values (non-null and valid)
  /// in the historical data. It then calculates an estimated value based on these.
  ///
  /// Throws:
  /// - [ArgumentError] if the provided date is higher than the highest known date
  ///   with a real value or lower than the lowest known date with a real value.
  ///
  /// Usage:
  /// ```
  /// double estimatedPrice = estimatePriceValue('2024.03');
  /// ```
  ///
  /// Arguments:
  /// - [date] : The date for which the price value is to be estimated. The date
  ///   should be in a format recognized by `DateUtils.getNextDate` and
  ///   `DateUtils.getPreviousDate`.
  ///
  /// Returns:
  /// A [double] representing the estimated price value for the given date.
  double estimatePriceValue(date) {
    final highestDate = getHighestDateWithRealValue();
    if (compareDates(date, highestDate) > 0) {
      throw ArgumentError(
          "The provided date is higher than expected and we cannot give an estimation: $date");
    }

    final lowestDate = getLowestDateWithRealValue();
    if (compareDates(date, lowestDate) < 0) {
      throw ArgumentError(
          "The provided date is lower than expected and we cannot give an estimation: $date");
    }

    // Get the next value in the future, if it exists.
    int upHops = 0;
    String nextDate = date;
    while (nextDate != highestDate) {
      upHops++;
      nextDate = DateUtils.getNextDate(nextDate);
      if (prices[nextDate] != null && prices[nextDate]!.isReal()) {
        break;
      }
    }

    int downHops = 0;
    String previousDate = date;
    while (previousDate != lowestDate) {
      downHops++;
      previousDate = DateUtils.getPreviousDate(previousDate);
      if (prices[previousDate] != null && prices[previousDate]!.isReal()) {
        break;
      }
    }

    // Calculate the average value between previousDate and nextDate.
    double upValue = prices[nextDate]!.getRealValue()!;
    double downValue = prices[previousDate]!.getRealValue()!;
    double estimatedValue;

    estimatedValue =
        ((upValue - downValue) / (upHops + downHops)) * downHops + downValue;

    return estimatedValue;
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
